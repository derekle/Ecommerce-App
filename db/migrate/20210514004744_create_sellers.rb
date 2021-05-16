class CreateSellers < ActiveRecord::Migration[6.1]
  def change
    create_table :sellers do |t|
      t.string :username
      t.string :password_digest
      t.integer :product_id
    end
  end
end
