class ProductController < ApplicationController
    ## control product CRUD logic. ##

    # index product - index page to display all products that belong to a user
    get '/products' do
        redirect_if_not_logged_in
        erb :'product/index'
    end
    # new product - displays create product form
    get '/products/create' do
        redirect_if_not_logged_in
        erb :'product/create'
    end
    # create product - creates one product
    post '/products' do
        if !params[:productname].empty? && !params[:price].empty? && !params[:quantity].empty?
            if Product.where(productname:params[:productname],user_id:current_user.id).empty?
                Product.create(productname:params[:productname], price:params[:price], quantity:params[:quantity], user_id:session[:user_id])
            else 
                redirect "/products/#{Product.where(productname:params[:productname],user_id:current_user.id).first.id}/edit/sell"
            end
        end
        redirect_to_index
    end
    # show product - displays one product based on ID in the url
    get '/products/:user_id/:id' do
        @userid = params[:user_id].to_i
        p @userid
        Product.set_product(Product.where(id:params[:id], user_id:@userid).first)
        p Product.get_current_product
        erb :'/product/show'
    end   
    # edit product - displays edit form based on ID in the url
    get '/products/:id/edit/sell' do
        redirect_if_not_logged_in
        if current_user.id == Product.find(params[:id]).user_id
            @productname = Product.find(params[:id]).productname
            @productid = params[:id]
            @userid = params[:userid]
            Product.set_product(Product.allProductByUser(params[:id]).first)
        end
        erb :'/product/edit'
    end

    post '/products/:id/edit/buy' do
        redirect_if_not_logged_in
        #check if user has funds
        if !User.funds?(params,current_user)
            redirect '/account/:id/edit/funds'
        end
        if Product.find(params[:productid]).quantity == 0
            redirect :"/products/#{params[:productid]}"
        end
        Product.buy(params,current_user)
        redirect_to_index
    end
    # update product - modifies an existing product based on ID in the url
    patch '/products/:id' do
        redirect_if_not_logged_in
        this_product = Product.find(params[:productid])
        if !params[:productname].empty?
            this_product.update(productname:params[:productname])
        end
        if !params[:price].empty?
            this_product.update(price:params[:price])
        end
        if !params[:quantity].empty?
            this_product.update(quantity:params[:quantity])
        end
        redirect_to_index
    end
    # update product - replaces an existing product based on ID in the url
    put '/products/:id' do
        redirect_if_not_logged_in
    end
    # delete product - deletes one product based on ID in the url
    delete '/products/:id' do
        redirect_if_not_logged_in
		if Product.find(params[:id]).user_id == current_user.id
			Product.find(params[:id]).destroy
		end
        redirect_to_index
    end
end