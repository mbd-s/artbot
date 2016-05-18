# require 'http'
# require 'json'
# require 'eventmachine'
# require 'faye/websocket'


module SlackBotHooks
  # create array from all art id's
  @@art = Art.pluck(:id)

  # stores last art piece shared
  @@current_art = nil

  # stores current answer to quiz (nil if quiz isnt active)
  @@answer = nil

  def open(event)
    p "open event triggered"
    nil
  end

  def message(event, bot_id)

    p "Message event triggered"
    data = JSON.parse(event.data)
    # uncomment line below to see full set of incoming data
    p [:message, JSON.parse(event.data)]
    p data
    return if data['user'] == bot_id
    msg = data['text']

    if msg =~ /art me/i
      p "art me triggered"
      #remove @@current_art from @@art array
      if @@art.empty?
        {
          type: 'message',
          text: "Out of art! Enter `<@#{bot_id}> refresh` to refresh the art library.",
          channel: data['channel'],
        }
      else
        # remove random ID from @@art and update @@current_art to the full Art piec from the DB
        @@current_art = Art.find_by_id(@@art.delete(@@art.sample))
        {
          type: 'message',
          text: "#{@@current_art.image}",
          channel: data['channel'],
        }
      end

    # QUIZ ME INITIALIZE
  elsif (msg =~ /quiz me/i)
      p "quiz me triggered"

      if !@@answer #no active quiz
        q = Question.all.sample
        @@answer = q.answer
        {
          type: 'message',
          text: "```QUESTION\n#{q.text}```",
          channel: data['channel']
        }
      else #quiz is active
        p "quiz already active"
        {
          type: 'message',
          text: "You are already in the middle of a quiz! Please respond with the answer or `<@#{bot_id}> answer` to finish this quiz.",
          channel: data['channel']
        }
      end

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

    elsif msg == "hi <@#{bot_id}>"
      p "hi @artbot triggered"
      res = "Hi, <@#{data['user']}>."
      p "returning #{res}"
      {
        type: 'message',
        text: "#{res}",
        channel: data['channel']
      }

    elsif msg == "<@#{bot_id}> artists"
      p "@artbot artists triggered"
      res = Artist.all.map {|x| x.name}.join("\n")
      p "returning #{res}"
      {
        type: 'message',
        text: "#{res}",
        channel: data['channel']
      }

    elsif msg == "<@#{bot_id}> help"
      p "@artbot help triggered"
      {
        type: 'message',
        text: "*For a list of commands, type:*\n`art me` to get a random art work \n`hi <@#{bot_id}>` to get a greeting back\n`<@#{bot_id}> artists` to get a list of artists back\n`<@#{bot_id}> help` to get this list of commands :)",
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
    #capture @@bot_id to use in message

    if rc && !rc['self']
      p "FAILED TO CONNECT TO SLACK BOT"
      return nil
    end

    @@bot_id = rc['self']['id']
    url = rc['url']
    p "bot_id = #{@@bot_id}"

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
      when :message then message(event, @@bot_id)
      when :close   then close(event)
    end
  end

  def self.die_gracefully
    Signal.trap("INT") { EM.stop }
    Signal.trap("TERM") { EM.stop }
  end

end
