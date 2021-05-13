class ApplicationController < Sinatra::Base
  ## control app startup and general logic ##
  # configuration
  configure do
      set :views, 'app/views'
      # A session is used to keep state during requests. If activated, you have one session hash per user session: #
      enable :sessions
      # Throws an exception if SESSION_SECRET does not exist in the current ENV. Set random hex for session secret. 
      # Solution found from sinatra documentation and user grempe in this thread: https://github.com/sinatra/sinatra/issues/1187
      set :session_secret, ENV.fetch('SESSION_SECRET') { SecureRandom.hex(64) }      
  end

  get '/' do
    erb :index
  end

  # define helper methods for use in route handlers and templates: #
  helpers do
  end
end 