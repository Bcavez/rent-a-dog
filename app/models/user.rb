class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true
  validates :lastname, presence: true
  validates :email, uniqueness: true
  validates :address, presence: true

  has_many :dogs, dependent: :destroy
  has_many :bookings, dependent: :destroy
end
