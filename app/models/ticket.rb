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

        seats_booked = Ticket.where(flight_id: flight).count
        total_seats = flight.aeroplane.number_of_seats 
        # if seats_booked >= 1/2*total_seats
        #    self.total_amount = flight.aeroplane.business_base_fare + 10/100*flight.aeroplane.business_base_fare
        if seatarray[0].casecmp("Business")==0 && seats_booked >= total_seats/2
          self.total_amount= flight.aeroplane.business_base_fare + flight.aeroplane.business_base_fare/10
        elsif seatarray[0].casecmp("First Class")==0 && seats_booked >= total_seats/2
          self.total_amount= flight.aeroplane.first_class_base_fare + flight.aeroplane.first_class_base_fare/10
        elsif seatarray[0].casecmp("Economy")==0 && seats_booked >= total_seats/2
          self.total_amount= flight.aeroplane.economy_base_fare + flight.aeroplane.economy_base_fare/10
        end

        if seatarray[0].casecmp("Business")==0 && seats_booked < total_seats/2
          self.total_amount= flight.aeroplane.business_base_fare
        elsif seatarray[0].casecmp("First Class")==0 && seats_booked < total_seats/2
          self.total_amount= flight.aeroplane.first_class_base_fare
        elsif seatarray[0].casecmp("Economy")==0 && seats_booked < total_seats/2
          self.total_amount= flight.aeroplane.economy_base_fare
        end

    end

end
