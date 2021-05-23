class CreateProducts < ActiveRecord::Migration[6.1]
  def change
    create_table :products do |t|
      t.string :productname
      t.float :price
      t.integer :quantity
      t.integer :user_id
    end  
  end
end
