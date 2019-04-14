class CreateMapPhotos < ActiveRecord::Migration[5.1]
  def change
    create_table :map_photos do |t|
      t.string :url, null: false
      t.string :name, null: false
      t.integer :size, null: false
      t.integer :original_id
      t.string :system
      t.integer :item_id

      t.timestamps
    end
  end
end
