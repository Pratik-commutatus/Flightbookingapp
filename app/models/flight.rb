class Flight < ApplicationRecord
  belongs_to :aeroplane
  has_many :tickets, dependent: :destroy
  has_many :passengers, through: :tickets, dependent: :destroy

  validates :source, presence: true
  validates :destination, presence: true
  
  validate :arr_dep

  def arr_dep
    if arrival<=departure
      errors.add(:arrival, "should be later than Departure")
    end
  end
end
