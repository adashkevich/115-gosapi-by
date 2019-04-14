class AddLockAndSubmitterNameToItems < ActiveRecord::Migration[5.1]
  def change
    add_column :map_items, :lock, :boolean
    add_column :map_items, :submitter_name, :string
  end
end
