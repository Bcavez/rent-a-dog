class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: :home

  def home
    # pass list of top 5 dogs to the home#views
    @top_five = Dog.joins(:reviews)
      .select("dogs.id, avg(reviews.rating) as average_rating")
      .group("dogs.id")
      .order("average_rating DESC")
      .limit(5)
      .map { |dog| Dog.find(dog.id) }
    # pass the average ratings of each dogs to the views to be displayed on the card
    # to use with each_with_index in the views. order of both arrays is the same
    @stars = @top_five.map { |dog| dog.reviews.average(:rating) }

    # @stars = @top_ten.map { |dog| Dog.average_rating(dog) }
    # @stars = @top_ten.map { |dog| dog.reviews.average(:rating) }
  end
end
