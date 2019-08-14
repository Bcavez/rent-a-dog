class DogsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:preview, :index]
  before_action :set_user, only: [:new, :create]
  before_action :set_dog, only: [:show, :edit, :update, :destroy, :preview]

  def show
    # give the bookings of the dog as an array to the views
    @bookings = @dog.bookings
    # give the use instance of the owner of the dog to the views
    @owner = @dog.user

    # FOR LATER, give the reviews as an array to the views
    # @reviews = @dog.reviews
  end

  def index
    # return array of all the dogs in the DB
    @dogs = Dog.all
  end

  def new
    # pass a new dog empty dog instance to the view
    @dog = Dog.new
  end

  def create
    # create the dog with the params from the form
    @dog = Dog.new(dog_params)
    # set the owner to the dog
    @dog.user = @user

    # redirects to the show page of the dog if the create is successfull otherwise render new form
    if @dog.save
      redirect_to dog_path(@dog)
    else
      render :new
    end
  end

  def edit
  end

  def update
    # goes to show page of the dog if update is successfull.
    if @dog.update(dog_params)
      redirect_to dog_path(@dog)
    else
      render :edit
    end
  end

  def destroy
    @user = @dog.user
    @dog.destroy

    redirect_to user_path(@user)
  end

  def preview
    # give the bookings of the dog as an array to the views
    @bookings = @dog.bookings
    # give the user instance of the owner of the dog to the views
    @owner = @dog.user

    # FOR LATER, give the reviews as an array to the views
    # @reviews = @dog.reviews
  end

  private

  def set_dog
    # give the dog instance to the view
    @dog = Dog.find(params[:id])
  end

  def set_user
    # give the owner instance to the view
    @user = current_user
  end

  def dog_params
    params.require(:dog).permit(:name, :race, :size, :description, :available, :image)
  end
end
