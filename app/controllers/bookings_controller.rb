class BookingsController < ApplicationController
  # sets the variable @booking for show and delete
  before_action :set_booking, only: [:show, :destroy]
  # sets the variable @dog for new and create
  before_action :set_dog, only: [:new, :create]
  # sets the variable @user for dashboard, new and create
  before_action :set_user, only: [:dashboard, :new, :create]

  def dashboard
    # a user can see all of his bookings
    @bookings = Booking.where(user_id: @user[:id])
    # send an array of all the dogs associated with the bookings to the views
    @dogs = @bookings.map(&:dog)
    # send an array of all the renter associated with the bookings to the views
    @renter = @bookings.map(&:user)
  end

  def show
    @dog = @booking.dog
    @user = @booking.user
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

  def destroy
    # sets the dog so that we can redirect later
    @dog = @booking.dog
    @booking.destroy

    # redirect to the show page of the dog associated to the deleted booking
    redirect_to dog_path(@dog)
  end

  private

  def set_user
    # @user variable is equal to the user that is currently logged in
    @user = current_user
  end

  def set_booking
    # query the booking instance from the DB using the params
    @booking = Booking.find(params[:id])
  end

  def set_dog
    # query the dog instance from the DB using the params
    @dog = Dog.find(params[:dog_id])
  end

  def booking_params
    params.require(:booking).permit(:description, :date)
  end
end
