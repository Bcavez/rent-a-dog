class Dog < ApplicationRecord
  validates :name, presence: true
  validates :race, presence: true
  validates :type, presence: true, inclusion: { in: %w(small medium large),
    message: "%{value} is not a valid type" }
  has_many :bookings, dependent: :destroy
  has_many :reviews, dependent: :destroy
  belongs_to :user
end
