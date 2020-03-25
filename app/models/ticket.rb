class Ticket < ApplicationRecord
    belongs_to :passenger, dependent: :destroy
    belongs_to :user, dependent: :destroy
    belongs_to :flight
    accepts_nested_attributes_for :passenger, allow_destroy: true

    
    before_save :ticket_details

    def ticket_details

      selected_aeroplane = Flight.find(flight_id).aeroplane
      seatarray = seat_number.split('.')
      self.seat_class = seatarray[0]
      self.seat_number = seatarray[1]
  
      self.pnr = "#{seat_class[0..1].upcase}"+"#{seat_number}"+"F"+"#{flight_id}"+"P"+"#{passenger_id}"

      seats_booked = Ticket.where(flight_id: flight).count
      total_seats = flight.aeroplane.number_of_seats 
      # if seats_booked >= 1/2*total_seats
      #    self.total_amount = flight.aeroplane.business_base_fare + 10/100*flight.aeroplane.business_base_fare

      def repeat_next(str, n)
        n.times.inject(str) { |s| s.next }
      end

      b_r = selected_aeroplane.business_rows
      f_r = selected_aeroplane.first_class_rows
      e_r = selected_aeroplane.economy_rows

      b_window1 = repeat_next("@", b_r/b_r)
      b_window2 = repeat_next("@", b_r)
      b_aisle1 = repeat_next("@", b_r/2)
      b_aisle2 = repeat_next("@", b_r/2 + 1)

      f_window1 = repeat_next("@", f_r/f_r)
      f_window2 = repeat_next("@", f_r)
      f_aisle1 = repeat_next("@", f_r/2)
      f_aisle2 = repeat_next("@", f_r/2 + 1)

      e_window1 = repeat_next("@", e_r/e_r)
      e_window2 = repeat_next("@", e_r)
      e_aisle1 = repeat_next("@", e_r/2)
      e_aisle2 = repeat_next("@", e_r/2 + 1)



      if seatarray[0].casecmp("Business")==0 && seats_booked < total_seats/2
        self.total_amount= flight.aeroplane.business_base_fare
      elsif seatarray[0].casecmp("First Class")==0 && seats_booked < total_seats/2
        self.total_amount= flight.aeroplane.first_class_base_fare
      elsif seatarray[0].casecmp("Economy")==0 && seats_booked < total_seats/2
        self.total_amount= flight.aeroplane.economy_base_fare
      end




      if seatarray[0].casecmp("Business")==0 && seats_booked >= total_seats/2 
        if seatarray[1].last == b_window1 || seatarray[1].last == b_window2 || seatarray[1].last == b_aisle1 || seatarray[1].last == b_aisle2
          self.total_amount= flight.aeroplane.business_base_fare + flight.aeroplane.business_base_fare/10
        else
          self.total_amount= flight.aeroplane.business_base_fare
        end
      
      elsif seatarray[0].casecmp("First Class")==0 && seats_booked >= total_seats/2
        if seatarray[1].last == f_window1 || seatarray[1].last == f_window2 || seatarray[1].last == f_aisle1 || seatarray[1].last == f_aisle2
          self.total_amount= flight.aeroplane.first_class_base_fare + flight.aeroplane.first_class_base_fare/10
        else
          self.total_amount= flight.aeroplane.first_class_base_fare
        end

      elsif seatarray[0].casecmp("Economy")==0 && seats_booked >= total_seats/2
        if seatarray[1].last == e_window1 || seatarray[1].last == e_window2 || seatarray[1].last == e_aisle1 || seatarray[1].last == e_aisle2
          self.total_amount= flight.aeroplane.economy_base_fare + flight.aeroplane.economy_base_fare/10
        else
          self.total_amount= flight.aeroplane.economy_base_fare
        end
        
      end

      

    end

end
