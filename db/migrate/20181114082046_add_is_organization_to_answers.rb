class AddIsOrganizationToAnswers < ActiveRecord::Migration[5.1]
  def change
    add_column :answers, :is_organization, :boolean, default: true
  end
end
