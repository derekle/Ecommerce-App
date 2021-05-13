class ApplicationController < Sinatra::Base
  ## control app startup and general logic ##
    configure do
        set :views, 'app/views'
    end

    get '/' do
      erb :index
    end
  end 