class AddEnddateToBookings < ActiveRecord::Migration[5.2]
  def change
    add_column :bookings, :enddate, :datetime
  end
end
