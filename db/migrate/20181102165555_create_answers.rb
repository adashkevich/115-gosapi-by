class CreateAnswers < ActiveRecord::Migration[5.1]
  def change
    create_table :answers do |t|
      t.string :text
      t.string :organization
      t.belongs_to :problem, index: true
    end
  end
end
