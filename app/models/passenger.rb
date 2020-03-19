class Passenger < ApplicationRecord

    belongs_to :user
    has_many :tickets
    has_many :flights, through: :tickets
    
end
