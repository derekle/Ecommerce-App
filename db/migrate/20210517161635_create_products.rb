class CreateProducts < ActiveRecord::Migration[6.1]
  def change
    create_table :products do |t|
      t.string :projectname
      t.float :price
      t.integer :client_id
    end  
  end
end
