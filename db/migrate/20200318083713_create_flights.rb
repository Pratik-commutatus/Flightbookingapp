class CreateFlights < ActiveRecord::Migration[6.0]
  def change
    create_table :flights do |t|
      t.date :date
      t.time :departure
      t.time :arrival
      t.string :source
      t.string :destination
      t.references :aeroplane, null: false, foreign_key: true

      t.timestamps
    end
  end
end
