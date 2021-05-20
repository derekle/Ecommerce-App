class AccountController < ApplicationController
	## control account CRUD logic. Users MUST be logged in to view account controls. ##
		#index - index page to display account actions, show account details for transactions
	get '/account' do
		redirect_if_not_logged_in
		erb :'user/account'               
	end
	    #show - displays one account based on ID in the url
	get '/account/:id' 	do
        redirect_if_not_logged_in
		erb :'user/show'    
	end
		#edit - displays edit form based on ID in the url
	get '/account/:id/edit/name' do
		redirect_if_not_logged_in	  
		erb :'user/edit/name'    
	end
	get '/account/:id/edit/password' do
		redirect_if_not_logged_in	  
		erb :'user/edit/password'    
	end
    get '/account/:id/edit/funds' do
		redirect_if_not_logged_in	  
		erb :'user/edit/funds'    
	end
    get '/account/:id/edit/orders' do
		redirect_if_not_logged_in	  
		@sellerid = current_user.id
		erb :'user/edit/orders'    
	end
	get '/account/:id/edit/delete' do
		redirect_if_not_logged_in	  
		erb :'user/edit/delete'    
	end

		#update - modifies an existing account based on ID in the url
	patch '/account/:id/edit/name'	do
		redirect_if_not_logged_in 
		if !params[:username].empty?
			User.find(params[:id]).update(username:params[:username])
        end
        redirect to "/account"
	end
    patch '/account/:id/edit/password'	do
        redirect_if_not_logged_in
        if !params[:password].empty?
            User.find(params[:id]).update(password:params[:password])
        end
        redirect to "/account"
    end
    patch '/account/:id/edit/funds'	do
        redirect_if_not_logged_in
        if !params[:funds].empty?
			if current_user.funds == nil
				current_user.update(funds:"0.0")
			end
            updated_funds = User.find(params[:id]).funds += params[:funds].to_f
            User.find(params[:id]).update(funds:updated_funds)
        end     
        redirect to "/account"
    end
		#delete - deletes one account based on ID in the url
	delete  '/account/:id'	  do
		redirect_if_not_logged_in 
		Product.all.where(seller_id:current_user.id).each do |x|
			x.destroy
		end
		current_user.destroy
		redirect to "/logout"
	end
end
