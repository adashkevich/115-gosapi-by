class AddCommentsToProblems < ActiveRecord::Migration[5.1]
  def change
    add_column :problems, :comments_count, :integer, default: 0
    add_column :problems, :comments, :string
  end
end
