class AccountController < ApplicationController
        ## control account CRUD logic. Users MUST be logged in to view account controls. ##
        
        #index 	index page to display account actions, show account details for transactions
        get '/account' do
                # redirect_if_not_logged_in
                erb :'user/account'               
        end
        #new   	displays create account form  
        get '/account/new' do  
            redirect_if_not_logged_in   
            erb :index
        end
        #create 	creates one account
        post '/account'  do
            redirect_if_not_logged_in	        
        end
        #show   	displays one account based on ID in the url
        get '/account/:id' 	do
            redirect_if_not_logged_in    
        end
        #edit 	displays edit form based on ID in the url
        get '/account/:id/edit' do
            redirect_if_not_logged_in	    
        end
        #update 	modifies an existing account based on ID in the url
        patch '/account/:id'	do
            redirect_if_not_logged_in       
        end
        #update 	replaces an existing account based on ID in the url
        put '/account/:id'	  do 
            redirect_if_not_logged_in         
        end
        #delete 	deletes one account based on ID in the url
        delete  '/account/:id'	  do
            redirect_if_not_logged_in      
        end
end

