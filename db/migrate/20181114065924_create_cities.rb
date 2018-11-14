class CreateCities < ActiveRecord::Migration[5.1]
  def change
    create_table :cities do |t|
      t.string :name
      t.date :from
      t.date :last_parsing

      t.timestamps
    end
  end
end
