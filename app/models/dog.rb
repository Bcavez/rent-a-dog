class Dog < ApplicationRecord
  include PgSearch

  validates :name, presence: true
  validates :race, presence: true
  validates :size, presence: true, inclusion: { in: %w(small medium large),
    message: "%{value} is not a valid size" }
  validates :address, presence: true
  has_many :bookings, dependent: :destroy
  has_many :reviews, dependent: :destroy
  belongs_to :owner, class_name: 'User'

  mount_uploader :photo, PhotoUploader

  pg_search_scope :search_dog_scope,
                  against: [:name, :race, :size, :description],
                  associated_against: {
                    user: [:name, :lastname]
                  },
                  using: {
                    tsearch: { prefix: true }
                  }

  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?

  # def self.average_rating(dog)
  #   # replace the dog with an array of his reviews
  #   array = dog.reviews
  #   # replace each review object by the rating integer
  #   rating_array = array.map(&:rating)
  #   # compute the average
  #   length = array.length
  #   average = rating_array.sum.to_f / length
  #   # return the average rating float
  #   return average.round(2)
  # end
end
