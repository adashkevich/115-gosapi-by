class CreateFetchLogs < ActiveRecord::Migration[5.1]
  def change
    create_table :fetch_logs do |t|
      t.json :data
      t.date :fetch_for

      t.timestamps
    end
  end
end
