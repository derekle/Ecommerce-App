class User < ActiveRecord::Base
    ## User class logic ##
    has_secure_password
    has_many :products
    @@cart = []

    def get_funds
        if self.funds == nil
            self.funds = 0.00
        end
        self.funds
    end

    def self.cart(array=[])
        if !array.empty?
            @@cart << array
        end
        p @@cart
    end
end