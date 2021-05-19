class AccountController < ApplicationController
        ## control account CRUD logic. Users MUST be logged in to view account controls. ##
        
        #index 	index page to display account actions, show account details for transactions
        get '/account' do
                # redirect_if_not_logged_in
                erb :'user/account'               
        end
        #show   	displays one account based on ID in the url
        get '/account/:id' 	do
            erb :'user/show'    
        end

        #edit 	displays edit form based on ID in the url
        get '/account/:id/edit/name' do
            redirect_if_not_logged_in	  
            erb :'user/edit/name'    
        end
        get '/account/:id/edit/password' do
            redirect_if_not_logged_in	  
            erb :'user/edit/password'    
        end
        get '/account/:id/edit/delete' do
            redirect_if_not_logged_in	  
            erb :'user/edit/delete'    
        end
        #update 	modifies an existing account based on ID in the url
        patch '/account/:id'	do
            redirect_if_not_logged_in 
            if !params[:username].empty?
                User.find(params[:id]).update(username:params[:username])
                redirect to "/account"
            else
                redirect to "/account"
            end     
        end

        #update 	replaces an existing account based on ID in the url
        put '/account/:id'	  do 
            redirect_if_not_logged_in         
        end

        #delete 	deletes one account based on ID in the url
        delete  '/account/:id'	  do
            redirect_if_not_logged_in 
            current_user.delete
            redirect to "/logout"
        end
end

