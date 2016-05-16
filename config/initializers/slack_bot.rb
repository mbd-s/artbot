unless ( File.basename($0) == 'rake')
   # exclude artbot from initializing during 'rake' commands
   require_relative "./../../bot/artbot.rb"
   SlackBotEM.start( ENV['SLACK_API_TOKEN'] )
end
