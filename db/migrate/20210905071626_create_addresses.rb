class CreateAddresses < ActiveRecord::Migration[5.0]
  def change
    create_table :addresses do |t|
      
      t.integer :customer_id, foreign_key: true
      t.string :name
      t.string :postal_code
      t.string :addresses

      t.timestamps
    end
  end
end