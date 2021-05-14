class Seller < ActiveRecord::Base
    ## Seller class logic ##
    has_secure_password
    has_many :products
end