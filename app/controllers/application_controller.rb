class ApplicationController < Sinatra::Base
	## control app startup and general logic ##
	# configuration
	configure do
		set :views, 'app/views'
		# A session is used to keep state during requests. If activated, you have one session hash per user session: #
		enable :sessions
		# Throws an exception if SESSION_SECRET does not exist in the current ENV. Set random hex for session secret. 
		# Solution found from sinatra documentation and user grempe in this thread: https://github.com/sinatra/sinatra/issues/1187
		set :session_secret, 'password'
	end
  # index
  get '/' do
binding.pry
		@ownerid=Product.all.map(&:owner_id).uniq
		erb :index
	end
  # define helper methods for use in route handlers and templates: #
	helpers do
		def logged_in?
			!!session[:user_id]
		end
    def redirect_to_index
			redirect '/'
		end
    def redirect_if_not_logged_in
			if !logged_in?
				redirect "/login"
				erb :login
			end
		end
    def is_unique?
			User.find_by_username(params[:username]) == nil
		end
    def current_user
			User.find(session[:user_id])
		end
	end
	def current_project
		Project.get_current_product
	end
end