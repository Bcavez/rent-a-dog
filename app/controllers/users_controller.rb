class UsersController < ApplicationController
  def show
    @user = current_user
    @dogs = @user.dogs
    @bookings = @user.bookings
  end
end
