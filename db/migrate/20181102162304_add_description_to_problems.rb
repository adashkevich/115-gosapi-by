class AddDescriptionToProblems < ActiveRecord::Migration[5.1]
  def change
    add_column :problems, :description, :string
  end
end
