class DropEconomies < ActiveRecord::Migration[6.0]
  def change
    drop_table :economies
  end
end
