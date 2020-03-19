class CreateTickets < ActiveRecord::Migration[6.0]
  def change
    create_table :tickets do |t|
      t.string :seat_class
      t.string :seat_number
      t.bigint :total_amount
      t.string :pnr

      t.timestamps
    end
  end
end
