class AddStartdateToBookings < ActiveRecord::Migration[5.2]
  def change
    add_column :bookings, :startdate, :datetime
  end
end
