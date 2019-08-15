class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: :home

  def home
    # pass list of top 10 dogs to the home#views
    # FOR NOW PASSES THE FIRST TEN DOGS, TO IMPLEMENT LATER WITH REVIEWS
    @top_ten = Dog.first(10)
    # pass the average ratings of each dogs to the views to be displayed on the card
    # to use with each_with_index in the views. order of both arrays is the same
    @stars = @top_ten.map { |dog| average_rating(dog) }
  end
end
