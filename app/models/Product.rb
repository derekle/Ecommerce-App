class Product < ActiveRecord::Base
    ## Product class logic ##
    belongs_to :sellers
    belongs_to :buyers
    @@current_product = nil
    ## get products
    def self.get_products
        p "getproducts"
        p self.all
        self.all
    end

    def self.get_seller(id)
        @seller = User.find(self.all[id].seller_id).username
    end

    def self.set_product(product)
        p "set_product"
        @@current_product = product[0]
    end

    def self.get_current_product
        @@current_product
    end

    def self.get_buyer(id)
        p "get_buyer"
        p id
        self.all[id].productname
    end

    
    def self.set_seller(id)
        p "set_seller"
        p id
        p self.all[id].productname
    end

    
    def self.set_buyer(id)
        p "set_buyer"
        p id
        p self.all[id].productname
    end
end