class AddReferencesToPassenger < ActiveRecord::Migration[6.0]
  def change
    add_reference :passengers, :user, null: false, foreign_key: true
  end
end
