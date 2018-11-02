class CreatePhotos < ActiveRecord::Migration[5.1]
  def change
    create_table :photos do |t|
      t.string :src
      t.string :category
      t.belongs_to :problem, index: true
    end
  end
end
