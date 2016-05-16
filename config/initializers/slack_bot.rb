unless ( File.basename($0) == 'rake')
   # Initializer code
   require_relative "./../../bot/artbot.rb"
   SlackBotEM.start( ENV['SLACK_API_TOKEN'] )
end
