class Aeroplane < ApplicationRecord
    has_many :flights
    has_many :passengers
end
