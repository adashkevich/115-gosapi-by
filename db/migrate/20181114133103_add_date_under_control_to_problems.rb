class AddDateUnderControlToProblems < ActiveRecord::Migration[5.1]
  def change
    add_column :problems, :date_under_control, :date
  end
end