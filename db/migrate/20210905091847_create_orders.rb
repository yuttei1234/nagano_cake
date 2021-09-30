class CreateOrders < ActiveRecord::Migration[5.0]
  def change
    create_table :orders do |t|
      
      t.integer :customer_id
      t.string :postal_code
      t.string :address
      t.string :name
      t.integer :shipping_cost, default: 800, null: false
      t.integer :total_payment, null: false
      t.integer :payment_method, default: 0
      t.integer :status, default: 0, null: false

      t.timestamps
    end
  end
end