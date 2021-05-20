require 'sinatra'
class Product < ActiveRecord::Base
    ## Product class logic ##
    belongs_to :sellers
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

    def self.get_seller(id)
        p id
        @seller = User.where(id:id.to_i).first.username
        p @seller
        @seller
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

    def self.set_seller(productid, sellerid)
        self.all[productid].seller_id = sellerid
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

    def self.build_table(sellerid)
        p sellerid
        @@table.clear
        array = []
         Product.where(seller_id:sellerid).each do |product|
            array << product.productname
            Product.get_cells.each do |attribute|
                array << product.send(attribute) 
            end
        end
        @@table = array.each_slice(get_cells.size+1).to_a.uniq
        @@table
    end
    def self.update_quantity(productname, myseller_id)
        Product.all.map(&:productname).uniq.each do |tag|
            qty = Product.all.count{|product| product.productname == tag}
            Product.where(productname:tag, seller_id:myseller_id).each do |p|
                p.update(quantity:qty)
            end
        end
    end
    def self.allProductBySeller(x)
        Product.where(productname: Product.find(x).productname , seller_id: Product.find(x).seller_id)
    end

    def self.allProductByBuyer(x, y)
        Product.where(productname: Product.find(x).productname , seller_id:y)
    end

    def self.get_id(productname, price, sellerid)
        Product.where(productname:productname , price:price, seller_id:sellerid).first.id
    end
end