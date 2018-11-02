class CreateProblems < ActiveRecord::Migration[5.1]
  def change
    create_table :problems do |t|
      t.string :href
      t.string :address
      t.st_point :location, geographic: true
      t.string :date_create
      t.date :date_planned
      t.date :crm_date_planned
      t.date :crm_create_at
      t.string :organisation_id
      t.string :status
      t.integer :rating
    end
  end
end
