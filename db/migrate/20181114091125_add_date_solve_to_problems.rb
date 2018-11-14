class AddDateSolveToProblems < ActiveRecord::Migration[5.1]
  def change
    add_column :problems, :date_solve, :date
  end
end
