class Aeroplane < ApplicationRecord
    has_many :flights
    has_many :passengers

    validates :model, presence: {message:": please enter something"}
    validates :number_of_seats, presence: {message:": please enter something"}
    validates :business_rows, presence: {message:": please enter something"}
    validates :business_columns, presence: {message:": please enter something"}
    validates :economy_rows, presence: {message:": please enter something"}
    validates :economy_columns, presence: {message:": please enter something"}
    validates :first_class_rows, presence: {message:": please enter something"}
    validates :first_class_columns, presence: {message:": please enter something"}
    validates :business_base_fare, presence: {message:": please enter something"}
    validates :economy_base_fare, presence: {message:": please enter something"}
    validates :first_class_base_fare, presence: {message:": please enter something"}

   
    validate :check_seats

    def check_seats
       if first_class_rows != nil && first_class_columns != nil && business_rows != nil && business_columns != nil 
         seat_count = (first_class_rows * first_class_columns) + (business_rows * business_columns) + (economy_rows * economy_columns)
         if number_of_seats != seat_count
            errors.add(:number_of_seats, "is wrong. Please enter correct number of passenger seats")
         end
      end
     end
end
