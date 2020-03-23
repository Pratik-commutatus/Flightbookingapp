class AddColumnToPassenger < ActiveRecord::Migration[6.0]
  def change
    add_column :passengers, :email, :string
  end
end
