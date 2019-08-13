class DogsController < ApplicationController
  def show
    # give the dog instance to the view
    @dog = Dog.find(params[:id])
    # give the bookings of the dog as an array to the views
    @bookings = @dog.bookings
    # give the owner of the dog to the views
    @owner = @dog.user

    # FOR LATER, give the reviews as an array to the views
    # @reviews = @dog.reviews
  end

  def index
    @dogs = Dog.all
  end

  def new
    @dog = Dog.new
    @user = User.find(params[:id])
  end

  def create
  end
end
