class CreateChangeLogs < ActiveRecord::Migration[5.1]
  def change
    create_table :change_logs do |t|
      t.string :old
      t.string :new
      t.string :field
      t.date :change_date, default: -> { 'CURRENT_TIMESTAMP' }
      t.belongs_to :problem, index: true
    end
  end
end
