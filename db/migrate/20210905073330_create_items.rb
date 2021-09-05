class CreateItems < ActiveRecord::Migration[5.0]
  def change
    create_table :items do |t|
      
      t.integer :genres_id, foreign_key: true
      t.string :name
      t.string :image_id
      t.text :introduction
      t.integer :price
      t.boolean :validation, default: true
      
      t.timestamps
    end
  end
end