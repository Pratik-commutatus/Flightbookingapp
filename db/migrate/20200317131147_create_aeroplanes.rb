class CreateAeroplanes < ActiveRecord::Migration[6.0]
  def change
    create_table :aeroplanes do |t|
      t.string :model
      t.bigint :number_of_seats

      t.timestamps
    end
  end
end
