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
            params[:quantity].to_i.times{Product.create(productname:params[:productname], price:params[:price], quantity:params[:quantity], seller_id:session[:user_id])}
        end
        redirect_to_index
    end
    # show product - displays one product based on ID in the url
    get '/products/:seller_id/:id' do
        @sellerid = params[:seller_id].to_i
        p @sellerid
        Product.set_product(Product.where(id:params[:id], seller_id:@sellerid).first)
        p Product.get_current_product
        erb :'/product/show'
    end   
    # edit product - displays edit form based on ID in the url
    get '/products/:id/edit/sell' do
        @productname = Product.find(params[:id]).productname
        @productid = params[:id]
        @sellerid = params[:sellerid]
        Product.set_product(Product.allProductBySeller(params[:id]).first)
        erb :'/product/edit'
    end

    get '/products/:id/edit/buy' do
        redirect_if_not_logged_in
        #check if user has funds
        if current_user.funds == nil
            current_user.update(funds:"0.0")
        end
        if current_user.funds >= Product.find(params[:productid]).price*params[:quantity].to_i
            allProductBySeller = Product.where(productname: Product.find(params[:productid]).productname , seller_id: Product.find(params[:productid]).seller_id)
            allProductByBuyer = Product.where(productname: Product.find(params[:productid]).productname , seller_id:current_user.id)
            allProductBySeller.first(params[:quantity].to_i).each do |product|
                product.update(seller_id:current_user.id)
            end
            Product.all.map(&:seller_id).uniq.each do |seller_id|
                Product.update_quantity(Product.find(params[:productid]).productname, seller_id)
            end
            updated_funds = current_user.funds -= Product.find(params[:productid]).price*params[:quantity].to_i
            current_user.update(funds:updated_funds)
            redirect :"/account/#{current_user.id}/edit/orders"
        else
            redirect :"/products/#{params[:productid]}"
        end
    end
    # update product - modifies an existing product based on ID in the url
    patch '/products/:id' do
        redirect_if_not_logged_in
        allProductBySeller = Product.where(productname: Product.find(params[:productid]).productname , seller_id: Product.find(params[:productid]).seller_id)
        allProductByBuyer = Product.where(productname: Product.find(params[:productid]).productname , seller_id:current_user.id)
        #must enter quantity
        if params[:quantity].empty?
            redirect :"/products/#{params[:productid]}/edit/sell"
        end
        if params[:quantity].to_i > Product.find(params[:productid]).quantity
            redirect :"/products/#{params[:productid]}/edit/sell"
        end
        if !params[:productname].empty?
            allProductBySeller.first(params[:quantity].to_i).each do |product|
                product.update(productname:params[:productname])
            end
        end
        if !params[:price].empty?
            allProductBySeller.first(params[:quantity].to_i).each do |product|
                product.update(price:params[:price])
            end
        end
            ##update quantity for this seller's listings
            Product.all.map(&:seller_id).uniq.each do |seller_id|
                Product.update_quantity(Product.find(params[:productid]).productname, params[:sellerid])
            end            
        erb :index
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