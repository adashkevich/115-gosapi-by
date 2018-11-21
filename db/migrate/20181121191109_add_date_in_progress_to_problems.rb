class AddDateInProgressToProblems < ActiveRecord::Migration[5.1]
  def change
    add_column :problems, :date_in_progress, :date
  end
end
