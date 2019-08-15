class Booking < ApplicationRecord
  validates :dog, presence: true
  validates :startdate, presence: true
  validates :enddate, presence: true
  validates :user, presence: true
  belongs_to :dog
  belongs_to :user
end
