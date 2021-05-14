class SessionController < ApplicationController
    ## control session CRUD logic ##
    
    ## signup logic
    get '/signup' do
        erb :'session/signup'
    end
    post '/sigup' do
    end

    ## login logic
    get '/login' do
        erb :'session/login'
    end
    post '/login' do
    end

    ## logout logic - destroy session when navigating to this page - redirect to homepage
    get '/logout' do
        session.destroy
        erb :index
    end
end