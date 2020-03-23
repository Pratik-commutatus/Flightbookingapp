class Flight < ApplicationRecord
  belongs_to :aeroplane
  has_many :tickets, dependent: :destroy
  has_many :passengers, through: :tickets, dependent: :destroy

  validates :source, presence: {message:": please enter something"}
  validates :destination, presence: {message:": please enter something"}
  
end
