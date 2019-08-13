class BookingsController < ApplicationController
  # sets the variable @booking for show
  before_action :set_booking, only: [:show]

  def show
  end

  private

  def set_booking
    # query the booking instance from the DB using the params
    @booking = Booking.new(params[:id])
  end
end
