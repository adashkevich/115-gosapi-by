class AddPublicationDateToAnswers < ActiveRecord::Migration[5.1]
  def change
    add_column :answers, :publish_date, :datetime
  end
end
