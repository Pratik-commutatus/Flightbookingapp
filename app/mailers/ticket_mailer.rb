class TicketMailer < ApplicationMailer
    helper :application
    default from: 'pratik@commutatus.com'

    def new_ticket_email
        @ticket = params[:ticket]
    
        mail(to: [@ticket.passenger.email, @ticket.user.email], subject: "Your ticket has been successfully booked!")
      end
end
