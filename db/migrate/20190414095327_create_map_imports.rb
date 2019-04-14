class CreateMapImports < ActiveRecord::Migration[5.1]
  def change
    create_table :map_imports do |t|
      t.integer :problem_id

      t.timestamps
    end
  end
end
