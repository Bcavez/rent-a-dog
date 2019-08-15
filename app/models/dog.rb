class Dog < ApplicationRecord
  validates :name, presence: true
  validates :race, presence: true
  validates :size, presence: true, inclusion: { in: %w(small medium large),
    message: "%{value} is not a valid size" }
  has_many :bookings, dependent: :destroy
  has_many :reviews, dependent: :destroy
  belongs_to :user

  mount_uploader :photo, PhotoUploader

  def average_rating(dog)
    # replace the dog with an array of his reviews
    array = dog.reviews
    # replace each review object by the rating integer
    array.map(&:rating)
    # compute the average
    length = array.length
    average = array.sum / length
    # return the average rating float
    return average
  end
end
