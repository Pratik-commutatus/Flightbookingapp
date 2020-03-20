class Ticket < ApplicationRecord
    belongs_to :passenger, dependent: :destroy
    belongs_to :flight
    accepts_nested_attributes_for :passenger, allow_destroy: true

    before_save :ticket_details

    def ticket_details

        selected_flight = Flight.find(flight_id)
        seatarray = seat_number.split('.')
        self.seat_class = seatarray[0]
        self.seat_number = seatarray[1]
    
        self.pnr = "#{seat_class[0..1].upcase}"+"#{seat_number}"+"F"+"#{flight_id}"+"P"+"#{passenger_id}"
    
        if seat_class.casecmp("Business")==0
          self.total_amount= flight.aeroplane.business_base_fare
        elsif seat_class.casecmp("First Class")==0
          self.total_amount= flight.aeroplane.first_class_base_fare
        else seat_class.casecmp("Economy")==0
          self.total_amount= flight.aeroplane.economy_base_fare
        end
    end

end
