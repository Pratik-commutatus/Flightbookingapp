class TicketPrint < Prawn::Document
    include ApplicationHelper
    def initialize(ticket)
        super()
        @ticket=ticket
        draw_text "Ticket Details", :at => [200,710], :size => 25
        text "
        


        
        Passenger name: #{@ticket.passenger.name} ( #{@ticket.passenger.age}, #{@ticket.passenger.gender} )

        Travelling From: #{@ticket.flight.source}

        Travelling To: #{@ticket.flight.destination}

        Date of Travel: #{@ticket.flight.date}

        Departure Time: #{readable_time(@ticket.flight.departure)}

        Arrival at Destination: #{readable_time(@ticket.flight.departure)}

        Seat Class: #{@ticket.seat_class}

        Seat Number: #{@ticket.seat_number}

        Total Amount: Rs. #{@ticket.total_amount}

        PNR Number: #{@ticket.pnr}

        ", :size => 18
    end
end