class Buyer < ActiveRecord::Base
    ## Buyer class logic ##
    has_secure_password
    has_many :products
end