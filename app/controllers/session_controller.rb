class SessionController < ApplicationController
	## control session CRUD logic ##
		## signup logic
	get '/signup' do
		erb :'session/signup'
	end
	post '/signup' do 
		# if fields are blank redirect to signup
		if params[:username] == "" || params[:password] == ""
			redirect to '/signup'
		else
			# check if username is unique
			if is_unique?
				@user = User.create(:username => params[:username], :password => params[:password])
				session[:user_id] = @user.id
				redirect_to_index
			else
				redirect '/signup'
			end
		end
	end
		## login logic
		get '/login' do 
		if !session[:user_id]
			erb :'session/login'
		else
			redirect_to_index
		end
	end
	post '/login' do
		user = User.find_by(:username => params[:username])
		if user && user.authenticate(params[:password])
			session[:user_id] = user.id
			redirect '/'
		else
			redirect to '/signup'
		end
	end
		## logout logic - destroy session when navigating to this page - redirect to homepage
	get '/logout' do
		if session[:user_id] != nil
			session.destroy
			redirect_to_index
		else
			redirect_to_index
		end
	end
end