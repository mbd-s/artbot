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
    p "message event triggered"
    data = JSON.parse(event.data)
    if data['text'] =~ /art me/i
      {
        type: 'message',
        text: Art.sample.image,
        channel: data['channel']
      }
    end
  end

  def close(event)
    p "close even triggered"
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

    url = rc['url']

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
