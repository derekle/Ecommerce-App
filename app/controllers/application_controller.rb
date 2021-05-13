class ApplicationController < Sinatra::Base
  ## control app startup and general logic ##
  # configuration
  configure do
      set :views, 'app/views'
      # A session is used to keep state during requests. If activated, you have one session hash per user session: #
      enable :sessions
  end

  get '/' do
    erb :index
  end

  # define helper methods for use in route handlers and templates: #
  helpers do
  end
end 