# require 'http'
# require 'json'
# require 'eventmachine'
# require 'faye/websocket'


module SlackBotHooks

  def open(event)
    p "open event triggered"
    nil
  end

  def message(event)
    p "Message event triggered"
    data = JSON.parse(event.data)
    # uncomment line below to see full set of incoming data
    p data
    msg = data['text']
    if msg =~ /art me/i
      p "art me triggered"
      p "returning #{Art.all.sample.image} "
      {
        type: 'message',
        text: Art.all.sample.image,
        channel: data['channel'],
      }
    elsif msg =~ /art vandelay/i
      p "art vandeley triggered"
      {
        type: 'message',
        text: "https://www.youtube.com/watch?v=j0Xtsi7Jcec",
        channel: data['channel']
      }
    elsif msg =~ /.*weather.*(in|at) (?<location>\w*)\?$/i
      m = data['text'].match(/.*weather.*(in|at) (?<location>\w*)\?$/i)
      {
        type: 'message',
        text: "The weather in #{m[:location]} is nice!",
        channel: data['channel']
      }
    elsif msg =~ /hi @artbot/i
      p "hi @artbot triggered"
      p "returning #{data['user']}"
      {
        type: 'message',
        text: "Hi, <@#{data['user']}>.",
        channel: data['channel']
      }
    elsif msg == "<@#{$bot_id}> artists"
      p "@artbot artists triggered"
      res = Artist.all.map {|x| x.name}.join("\n")
      p "returning #{res}"
      {
        type: 'message',
        text: "#{res}",
        channel: data['channel']
      }
    end

  end

  def close(event)
    p "close event triggered"
    nil
  end

end

module SlackBotEM
  extend SlackBotHooks

  def self.start(slack_api_token)
    rc = HTTP.post("https://slack.com/api/rtm.start", params: {
      token: slack_api_token
    })

    rc = JSON.parse(rc.body)
    $bot_id = rc['self']['id']
    url = rc['url']
    p "bot_id = #{$bot_id}"

    EM.next_tick {
      EM.run do
        ws = Faye::WebSocket::Client.new(url)

        ws.on :open do
          on(:open)
        end

        ws.on :message do |event|
          res = on(:message, event)
          ws.send(res.to_json) if res
        end

        ws.on :close do |event|
          on(:close, event)
          ws = nil
          EM.stop
        end
      end
    }
    die_gracefully
  end

  def self.on(signal_type, event=nil)
    case signal_type
      when :open    then open(event)
      when :message then message(event)
      when :close   then close(event)
    end
  end

  def self.die_gracefully
    Signal.trap("INT") { EM.stop }
    Signal.trap("TERM") { EM.stop }
  end

end
