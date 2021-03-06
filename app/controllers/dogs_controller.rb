class DogsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:preview, :index]
  before_action :set_user, only: [:new, :create]
  before_action :set_dog, only: [:show, :edit, :update, :destroy, :preview]

  def preview
    # give the bookings of the dog as an array to the views
    @bookings = @dog.bookings

    # give the user instance of the owner of the dog to the views
    @owner = @dog.user

    # give the reviews as an array to the views
    @reviews = @dog.reviews

    # give the user who created the review as an array with index associated to @reviews
    @authors = @reviews.map(&:user)

    # give the average rating of the dog as an integer
    # @stars = Dog.average_rating(@dog)
    @stars = @dog.reviews.average(:rating)
  end

  def show
    # give the bookings of the dog as an array to the views
    @bookings = @dog.bookings

    # give the use instance of the owner of the dog to the views
    @owner = @dog.user
    @markers = [{
        lat: @dog.latitude,
        lng: @dog.longitude,
        infoWindow: render_to_string(partial: "info_window", locals: { dog: @dog }),
        image_url: helpers.asset_url('/images/doge.png')
      }]

    # give the reviews as an array to the views
    @reviews = @dog.reviews

    # give the user who created the review as an array with index associated to @reviews
    @authors = @reviews.map(&:user)

    # give the average rating of the dog as an integer
    # @stars = Dog.average_rating(@dog)
    @stars = @dog.reviews.average(:rating)
  end

  def index

    if params[:query].present?
      search = Dog.search_dog_scope(params[:query])
      @dogs = search.geocoded
    else
      @dogs = Dog.geocoded # returns all dogs with coordinates
    end

    @markers = @dogs.map do |dog|
      {
        lat: dog.latitude,
        lng: dog.longitude,
        infoWindow: render_to_string(partial: "info_window", locals: { dog: dog }),
        image_url: helpers.asset_url('doge.png')
      }
    end
    # return array of all the dogs in the DB
    # @dogs = policy_scope(Dog.includes(:user))
    # give the average rating of the dog as an integer
    # @stars = @dogs.map { |dog| Dog.average_rating(dog) }
    @stars = @dogs.map { |dog| dog.reviews.average(:rating) }
    # @dogs = Dog.all
  end

  def new
    # pass a new dog empty dog instance to the view
    @dog = Dog.new
    authorize @dog
  end

  def create
    # create the dog with the params from the form
    @dog = Dog.new(dog_params)
    # @dog.photo = "/images/index.png" if @dog.photo.nil?

    authorize @dog
    # find the owner of the dog from the params of the form
    @user = current_user
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

  private

  def set_dog
    # give the dog instance to the view
    @dog = Dog.find(params[:id])
    authorize @dog
  end

  def set_user
    # give the owner instance to the view
    @user = current_user
  end

  def dog_params
    params.require(:dog).permit(:name, :race, :address, :size, :description, :available, :photo)
  end
end
