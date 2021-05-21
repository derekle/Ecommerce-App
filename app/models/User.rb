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

    def self.funds?(params,current_user)
        binding.pry
        if current_user.funds == nil || current_user.funds == 0
            current_user.update(funds:"0.0")
            false
        elsif (current_user.funds -=  Product.find(params[:productid]).price*params[:quantity].to_i) < 0
            false
        else
            true
        end
    end

    def self.cart(array=[])
        if !array.empty?
            @@cart << array
        end
        p @@cart
    end
end