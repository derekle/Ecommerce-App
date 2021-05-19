class ProductController < ApplicationController
    ## control product CRUD logic. ##

    # index product - index page to display all products
    get '/products' do
    end
    # new product - displays create product form
    get '/products/create' do
    end
    # create product - creates one product
    post '/products' do
    end
    # show product - displays one product based on ID in the url
    get '/products/:id' do
    end
    # edit product - displays edit form based on ID in the url
    get '/products/:id/edit' do
    end
    # update product - modifies an existing product based on ID in the url
    patch '/products/:id' do
    end
    # update product - replaces an existing product based on ID in the url
    put '/products/:id' do
    end
    # delete product - deletes one product based on ID in the url
    delete '/products/:id' do
    end
end