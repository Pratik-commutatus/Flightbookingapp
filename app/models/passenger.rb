class Passenger < ApplicationRecord

    belongs_to :user
    has_many :tickets
    has_many :flights, through: :tickets
    
    validates :name, presence: true
    validates :age, presence: true
    validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }
 
end
