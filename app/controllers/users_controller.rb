class UsersController < ApplicationController
  before_action :set_user, only: [:show, :dashboard]

  def show
    @dogs = policy_scope(Dog)
    @bookings = policy_scope(Booking)
    # @stars = @dogs.map { |dog| Dog.average_rating(dog) }
    @stars = @dogs.map { |dog| dog.reviews.average(:rating) }
  end

  def dashboard
    # a user can see all of his bookings, but owner will not yet see all the bookings for his dogs
    @bookings = Booking.joins(:dog)

    bookings_owner = BookingPolicy::Scope.new(current_user, @bookings).resolve

    if current_user.owner == true
      @s = bookings_owner.where('dogs.owner': current_user)
    else
      @s = bookings_owner.where(user: current_user)
    end
    # s = @bookings_owner.where(dog: { owner: current_user })
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
