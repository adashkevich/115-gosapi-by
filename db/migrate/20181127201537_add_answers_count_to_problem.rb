class AddAnswersCountToProblem < ActiveRecord::Migration[5.1]
  def change
    add_column :problems, :answers_count, :integer, default: 0
  end
end
