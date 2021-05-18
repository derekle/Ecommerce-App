class User < ActiveRecord::Base
    ## User class logic ##
    has_secure_password
    has_many :products
end