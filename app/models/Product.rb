class Product < ActiveRecord::Base
    ## Product class logic ##
    belongs_to :sellers
    belongs_to :buyers
end