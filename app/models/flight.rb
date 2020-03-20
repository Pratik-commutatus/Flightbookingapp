class Flight < ApplicationRecord
  belongs_to :aeroplane
  has_many :tickets, dependent: :destroy
  has_many :passengers, through: :tickets, dependent: :destroy
end
