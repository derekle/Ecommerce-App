class CreateProducts < ActiveRecord::Migration[6.1]
  def change
    create_table :products do |t|
      t.string :productname
      t.float :price
      t.integer :quantity
      t.integer :seller_id
      t.integer :buyer_id
    end  
  end
end
