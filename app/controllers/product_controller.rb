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
            Product.create(productname:params[:productname], price:params[:price], quantity:params[:quantity], seller_id:session[:user_id])
        end
        redirect_to_index
    end
    # show product - displays one product based on ID in the url
    get '/products/:id' do
        @index = params[:id].to_i-1
        @products = Array.new(1, Product.get_products[@index])
        Product.set_product(@products)
        p Product.get_current_product
        erb :'/product/show'
    end
    # edit product - displays edit form based on ID in the url
    get '/products/:id/edit' do
        redirect_if_not_logged_in
        erb :'/product/edit'
    end
    # update product - modifies an existing product based on ID in the url
    patch '/products/:id' do
        redirect_if_not_logged_in
    end
    # update product - replaces an existing product based on ID in the url
    put '/products/:id' do
        redirect_if_not_logged_in
    end
    # delete product - deletes one product based on ID in the url
    delete '/products/:id' do
        redirect_if_not_logged_in
    end
end