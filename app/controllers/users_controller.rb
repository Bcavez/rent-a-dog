class UsersController < ApplicationController
  before_action :set_user, only: [:show, :dashboard]
  def show
    @dogs = @user.dogs
    @bookings = @user.bookings

    authorize @user
  end

  def dashboard
    # a user can see all of his bookings
    @bookings = BookingPolicy::Scope.new(current_user, Booking).resolve
    # send an array of all the dogs associated with the bookings to the views
    @dogs = @bookings.map(&:dog)
    # send an array of all the renter associated with the bookings to the views
    @renter = @bookings.map(&:user)

    authorize @bookings
    # authorize @user
  end

  def set_user
    @user = current_user
  end
end
