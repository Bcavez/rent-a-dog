class Dog < ApplicationRecord



  validates :name, presence: true
  validates :race, presence: true
  validates :size, presence: true, inclusion: { in: %w(small medium large),
    message: "%{value} is not a valid size" }
  has_many :bookings, dependent: :destroy
  has_many :reviews, dependent: :destroy
  belongs_to :user

  mount_uploader :photo, PhotoUploader

end
