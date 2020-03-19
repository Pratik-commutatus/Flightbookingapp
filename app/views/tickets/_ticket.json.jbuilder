json.extract! ticket, :id, :seat_class, :seat_number, :total_amount, :pnr, :created_at, :updated_at
json.url ticket_url(ticket, format: :json)
