json.extract! flight, :id, :date, :departure, :arrival, :source, :destination, :aeroplane_id, :created_at, :updated_at
json.url flight_url(flight, format: :json)
