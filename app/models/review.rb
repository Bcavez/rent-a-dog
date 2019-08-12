class Review < ApplicationRecord
  validates :description, presence: true
  validates :rating, presence: true, numericality: { only_integer: true }
  belongs_to :dog
end
