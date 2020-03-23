class Passenger < ApplicationRecord

    belongs_to :user
    has_many :tickets
    has_many :flights, through: :tickets
    
    validates :name, presence: {message:": please enter something"}
    validates :age, presence: {message:": please enter something"}
    validates :email, uniqueness: {message:": Ticket already exists"}
end
