class BookingsController < ApplicationController
  # sets the variable @booking for show
  before_action :set_booking, only: [:show]
  # sets the variable @dog for new
  before_action :set_dog, only: [:new]

  def show
  end

  def new
    @booking = Booking.new
    @user = current_user
  end

  private

  def set_booking
    # query the booking instance from the DB using the params
    @booking = Booking.new(params[:id])
  end

  def set_dog
    @dog = Dog.new(params[:dog_id])
  end
end
