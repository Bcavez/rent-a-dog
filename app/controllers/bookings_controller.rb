class BookingsController < ApplicationController
  # sets the variable @booking for show
  before_action :set_booking, only: [:show]
  # sets the variable @dog for new
  before_action :set_dog, only: [:new, :create]
  # sets the variable @user for new and create
  before_action :set_user, only: [:new, :create]

  def show
  end

  def new
    # pass an empty booking instance to the view
    @booking = Booking.new
  end

  def create
    @booking = Booking.new(booking_params)
    # set the user and dog to the booking
    @booking.user = @user
    @booking.dog = @dog

    # if the booking is saved successfully, redirect to the booking show page
    if @booking.save!
      redirect_to booking_path(@booking)
    # otherwise render new form
    else render :new
    end
  end

  private

  def set_user
    # @user variable is equal to the user that is currently logged in
    @user = current_user
  end

  def set_booking
    # query the booking instance from the DB using the params
    @booking = Booking.new(params[:id])
  end

  def set_dog
    # query the dog instance from the DB using the params
    @dog = Dog.new(params[:dog_id])
  end

  def booking_params
    params.require(:booking).permit(:description, :date)
  end
end
