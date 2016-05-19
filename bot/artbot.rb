module SlackBotHooks
  # create array from all art id's
  @@art = []

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
      # reset art list if empty
      if @@art.empty?
        @@art = Art.pluck(:id)
      end

      # remove random ID from @@art and update @@current_art to the full Art piec from the DB
      @@current_art = Art.find_by_id(@@art.delete(@@art.sample))

      {
        type: 'message',
        text: "https://slack-artbot.herokuapp.com/arts/#{@@current_art.id}",
        channel: data['channel'],
      }

      # MORE INFO
    elsif @@current_art && msg == "<@#{bot_id}> more info"
      p "more info triggered"
      {
        type: 'message',
        text: "The #{@@current_art.medium} ​*#{@@current_art.title}*​ was created in ​*#{@@current_art.year}*​ by the #{@@current_art.artist.nationality} artist ​*#{@@current_art.artist.name}*​.",
        channel: data['channel']
      }

    # QUIZ ME INITIALIZE
    elsif (msg =~ /quiz me/i)
      p "quiz me triggered"

      if Question.count == 0 #no questions in db
        {
          type: 'message',
          text: "Sorry, no questions available for a quiz.",
          channel: data['channel']
        }

      elsif !@@answer #no active quiz
        q = Question.all.sample
        @@answer = q.answer
        {
          type: 'message',
          text: "#{q.art.image}\n```#{q.text}```\nPlease enter the correct answer, or enter `<@#{bot_id}> answer` to end the quiz.",
          channel: data['channel']
        }
      else #quiz is active
        p "quiz already active"
        {
          type: 'message',
          text: "You're already in the middle of a quiz! Please enter the correct answer, or enter `<@#{bot_id}> answer` to end the quiz.",
          channel: data['channel']
        }
      end

    # QUIZ ME **CORRECT ANSWER GIVEN**
  elsif @@answer && msg && msg.include?(@@answer)
      p "quiz correctly answered!"
      answer = @@answer
      @@answer = nil
      {
        type: 'message',
        text: "Correct, <@#{data['user']}>!\nThe answer was: `#{answer}`.",
        channel: data['channel']
      }

    # QUIZ ME TERMINATE **USER ASKS FOR ANSWER**
  elsif @@answer && msg == "<@#{bot_id}> answer"
      p "quiz me terminate(answer request) triggered"
      answer = @@answer
      @@answer = nil
      {
        type: 'message',
        text: "```QUIZ OVER!\nANSWER: #{answer}```",
        channel: data['channel']
      }

    elsif msg =~ /art vandelay/i
      p "art vandelay triggered"
      {
        type: 'message',
        text: "https://www.youtube.com/watch?v=j0Xtsi7Jcec",
        channel: data['channel']
      }

    elsif msg == "hi <@#{bot_id}>"
      p "hi @artbot triggered"
      res = "Hi, <@#{data['user']}>!"
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
        text: "*These are all the artists I know about right now:*\n#{res}",
        channel: data['channel']
      }

    elsif msg == "<@#{bot_id}> help"
      p "@artbot help triggered"
      {
        type: 'message',
        text: "*Here's what you can tell me to do:*\n`art me` I'll send you a random piece of art.\n`<@#{bot_id}> more info` I'll give you more information about the last artwork.\n`quiz me` I'll ask you questions about the art.\n`hi <@#{bot_id}>` I'll greet you back. (I'm polite.)\n`<@#{bot_id}> artists` I'll give you a list of all the artists currently in my gallery.\n`<@#{bot_id}> help` I'll resend this list of commands.",
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
