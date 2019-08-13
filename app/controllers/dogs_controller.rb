class DogsController < ApplicationController
  before_action :set_user, only: [:new]
  before_action :set_dog, only: [:show, :edit]

  def show
    # give the bookings of the dog as an array to the views
    @bookings = @dog.bookings
    # give the owner of the dog to the views
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
    # find the owner of the dog from the params of the form
    @user = User.find(params[:user_id])
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
