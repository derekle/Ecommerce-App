class User < ActiveRecord::Base
    ## User class logic ##
    has_secure_password
    has_many :products

    def get_funds
        if self.funds == nil
            self.funds = 0.00
        end
        self.funds
    end
end