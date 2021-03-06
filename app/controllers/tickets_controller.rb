class TicketsController < ApplicationController
  before_action :set_ticket, only: [:show, :edit, :update, :destroy]
  # before_action do 
  #    redirect_to new_user_session_path unless current_user
  # end
  before_action :authenticate_user!

  # GET /tickets
  # GET /tickets.json
  def index
    @tickets = Ticket.all.where(user_id: current_user.id)
    # @tickets = current_user.passengers
  end

  # GET /tickets/1
  # GET /tickets/1.json
  def show
    respond_to do |format|
      format.html
      format.pdf do
        pdf = TicketPrint.new(@ticket)
        send_data pdf.render, filename: "#{@ticket.passenger.name}.pdf", type: "application/pdf", disposition: "inline"
      end
    end
  end

  # GET /tickets/new
  def new
    @ticket = Ticket.new
    @ticket.flight_id = params[:flight_id] 
    @ticket.build_passenger
    @aeroplanes=Aeroplane.all
  end

  # GET /tickets/1/edit
  def edit
  end

  # POST /tickets
  # POST /tickets.json
  def create
    @ticket = Ticket.new(ticket_params)
    @ticket.flight_id = params[:flight_id] 
    
    respond_to do |format|
      if @ticket.save
        
        format.html { redirect_to @ticket, notice: 'Ticket was successfully created. You will recieve a confirmation email soon.' }
        format.json { render :show, status: :created, location: @ticket }


        ActionMailer::Base.smtp_settings = {
          :address              => "smtp.gmail.com",
          :port                 => 587,
          :user_name            => 'pratik@commutatus.com',
          :password             => 'lwlwfaildnhxxrln',
          :authentication       => "plain",
          :enable_starttls_auto => true
        }
        TicketMailer.with(ticket: @ticket).new_ticket_email.deliver_later

      else
        format.html { render :new }
        format.json { render json: @ticket.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tickets/1
  # PATCH/PUT /tickets/1.json
  def update
    respond_to do |format|
      if @ticket.update(ticket_params)
        format.html { redirect_to @ticket, notice: 'Ticket was successfully updated.' }
        format.json { render :show, status: :ok, location: @ticket }
      else
        format.html { render :edit }
        format.json { render json: @ticket.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tickets/1
  # DELETE /tickets/1.json
  def destroy
    @ticket.destroy
    respond_to do |format|
      format.html { redirect_to tickets_url, notice: 'Ticket was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ticket
      @ticket = Ticket.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def ticket_params
      params.require(:ticket).permit(:seat_class, :seat_number, :total_amount, :pnr, :flight_id, :user_id, passenger_attributes:[:id, :_destroy, :name, :user_id, :age, :gender, :email])
    end
end
