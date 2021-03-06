require 'sinatra'
class Product < ActiveRecord::Base
    ## Product class logic ##
    belongs_to :users
    belongs_to :buyers
    @@current_product = nil
    @@column_names = []
    @@cell_names = []
    @@table = []
    ## get products
    def self.get_products(tablesize=self.all.size)
        if tablesize != self.all.size
            return self.all[1..tablesize]
        end
        self.all
    end

    def self.get_user(id)
        p id
        @user = User.where(id:id.to_i).first.username
        p @user
        @user
    end

    def self.set_product(product)
        @@current_product = product
        p @@current_product
    end

    def self.get_current_product
        @@current_product
    end

    def self.get_buyer(id)
        self.all[id].buyer_id
    end

    def self.set_user(productid, userid)
        self.all[productid].user_id = userid
    end

    
    def self.set_buyer(productid, buyerid)
        self.all[productid].buyer_id = buyerid
    end

    def self.set_columns(array)
        @@column_names = array
    end
    def self.get_columns
        @@column_names
    end

    def self.set_cells(array)
        @@cell_names = array
    end

    def self.get_cells
        @@cell_names
    end

    def self.buy(params, current_user)
        this_product = Product.find(params[:productid])
        allProductByUser = Product.where(productname:this_product.productname, price:this_product.price, user_id:this_product.user_id)
        allProductByBuyer = Product.where(productname:this_product.productname, price:this_product.price, user_id:current_user.id)
        if allProductByBuyer.empty?
            Product.create(this_product.attributes.except("id").merge(user_id:current_user.id, quantity:params[:quantity].to_i))
        else 
            allProductByBuyer[0].update(quantity:this_product.quantity+params[:quantity].to_i)
        end
        this_product.update(quantity:this_product.quantity-params[:quantity].to_i)
        if this_product.quantity == 0
            this_product.destroy
        end
        
        current_user.update(funds:current_user.funds-this_product.price*params[:quantity].to_i)
        User.find(this_product.user_id).update(funds:User.find(this_product.user_id).funds+this_product.price*params[:quantity].to_i)
    end


    def self.build_table(userid)
        p userid
        @@table.clear
        array = []
         Product.where(user_id:userid).each do |product|
            array << product.productname
            Product.get_cells.each do |attribute|
                array << product.send(attribute) 
            end
        end
        @@table = array.each_slice(get_cells.size+1).to_a.uniq
        @@table
    end
    def self.update_quantity(productname, myuser_id)
        Product.all.map(&:productname).uniq.each do |tag|
            qty = Product.all.count{|product| product.productname == tag}
            Product.where(productname:tag, user_id:myuser_id).each do |p|
                p.update(quantity:qty)
            end
        end
    end
    def self.allProductByUser(x)
        Product.where(productname: Product.find(x).productname , user_id: Product.find(x).user_id)
    end

    def self.allProductByBuyer(x, y)
        Product.where(productname: Product.find(x).productname , user_id:y)
    end

    def self.get_id(productname, price, userid)
        Product.where(productname:productname , price:price, user_id:userid).first.id
    end
end