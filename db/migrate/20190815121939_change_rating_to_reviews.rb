class ChangeRatingToReviews < ActiveRecord::Migration[5.2]
  def change
    change_column :reviews, :rating, :integer, :default => 0
  end
end
