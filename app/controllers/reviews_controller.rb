class ReviewsController < ApplicationController
  # sets the variable @dog for new and create
  before_action :set_dog, only: [:new, :create]
  # sets the variable @user for new and create
  before_action :set_user, only: [:new, :create]

  def new
    # pass an empty booking instance to the view
    @review = Review.new
    authorize @review
  end

  def create
    @review = Review.new(review_params)
    # set the user and dog to the review
    @review.user = @user
    @review.dog = @dog
    authorize @review
    # if the review is saved successfully, redirect to the dog show page
    if @review.save
      redirect_to dog_path(@dog)
    # otherwise render new form
    else render :new
    end
  end

  private

  def set_user
    # @user variable is equal to the user that is currently logged in
    @user = current_user
  end

  def set_dog
    # query the dog instance from the DB using the params
    @dog = Dog.find(params[:dog_id])
    authorize @dog
  end

  def booking_params
    params.require(:review).permit(:description, :rating)
  end
end
