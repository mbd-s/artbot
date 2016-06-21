class WelcomeController < ApplicationController

  def index
    if params['code']
      rc = HTTP.post("https://slack.com/api/oauth.access", params:
      client_id: ENV['SLACK_CLIENT_ID'],
      client_secret: ENV['SLACK_CLIENT_SECRET']
      code: ENV['SLACK_API_TOKEN'])
  end

end
