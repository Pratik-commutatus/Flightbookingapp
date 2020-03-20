class TicketsController < ApplicationController
  before_action :set_ticket, only: [:show, :edit, :update, :destroy]

  # GET /tickets
  # GET /tickets.json
  def index
    @tickets = Ticket.all
  end

  # GET /tickets/1
  # GET /tickets/1.json
  def show
  end

  # GET /tickets/new
  def new
    @ticket = Ticket.new
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
    

    @seatarray=@ticket.seat_number.split('.')
    @ticket.seat_class=@seatarray[0]
    @ticket.seat_number=@seatarray[1]

    @ticket.pnr = "#{@ticket.seat_class[0..1].upcase}"+"#{@ticket.seat_number}"+"F"+"#{@ticket.flight_id}"+"P"+"#{@ticket.passenger_id}"

    if @ticket.seat_class.casecmp("Business")==0
      @ticket.total_amount= @ticket.flight.aeroplane.business_base_fare
    elsif @ticket.seat_class.casecmp("First Class")==0
      @ticket.total_amount= @ticket.flight.aeroplane.first_class_base_fare
    else @ticket.seat_class.casecmp("Economy")==0
      @ticket.total_amount= @ticket.flight.aeroplane.economy_base_fare
    end

    respond_to do |format|
      if @ticket.save
        format.html { redirect_to @ticket, notice: 'Ticket was successfully created.' }
        format.json { render :show, status: :created, location: @ticket }
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
      params.require(:ticket).permit(:seat_class, :seat_number, :total_amount, :pnr, :flight_id, passenger_attributes:[:id, :_destroy, :name, :user_id])
    end
end
