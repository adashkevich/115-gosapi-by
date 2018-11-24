class AddCityReferenceToProblem < ActiveRecord::Migration[5.1]
  def change
    add_reference :problems, :city, foreign_key: true
  end
end
