class CreateMapItems < ActiveRecord::Migration[5.1]
  def change
    create_table :map_items do |t|
      t.string :item_type
      t.string :coordinates
      t.integer :height
      t.integer :problem_id
      t.string :problem_href
      t.boolean :processed
      t.string :problem_status
      t.string :problem_answer

      t.timestamps
    end
  end
end
