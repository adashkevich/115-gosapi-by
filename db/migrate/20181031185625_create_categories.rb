class CreateCategories < ActiveRecord::Migration[5.1]
  def change
    create_table :categories do |t|
      t.string :icon
      t.string :parent_id
    end

    add_reference :problems, :category, foreign_key: true
  end
end
