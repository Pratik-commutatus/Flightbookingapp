class CreateJoinTablePassengerAeroplane < ActiveRecord::Migration[6.0]
  def change
    create_join_table :passengers, :aeroplanes do |t|
      # t.index [:passenger_id, :aeroplane_id]
      # t.index [:aeroplane_id, :passenger_id]
    end
  end
end
