class ChangeDataImageIdToItem < ActiveRecord::Migration[5.0]
  def change
    change_column :items, :image_id, :string
  end
end
