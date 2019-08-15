class UsersController < ApplicationController
  before_action :set_user, only: [:show, :dashboard]
  def show
    @dogs = policy_scope(Dog)
    @bookings = policy_scope(Booking)
    @stars = @dogs.map { |dog| Dog.average_rating(dog) }
  end

  def dashboard
    # a user can see all of his bookings, but owner will not yet see all the bookings for his dogs
    @bookings = BookingPolicy::Scope.new(current_user, Booking).resolve

    # TODO: Load the dogs of the user in a variable
    # TODO: Load the booking where dog is in the list of dogs from the owner

    # send an array of all the dogs associated with the bookings to the views
    @dogs = @bookings.map(&:dog)
    # send an array of all the renter associated with the bookings to the views
    @renter = @bookings.map(&:user)
  end

  def set_user
    @user = current_user
    authorize @user
  end
end
