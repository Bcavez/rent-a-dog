class Booking < ApplicationRecord
  validates :dog, presence: true
  validates :date, presence: true
  validates :user, presence: true
  belongs_to :dog
  belongs_to :user
end
