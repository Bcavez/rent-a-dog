class ChangePayedConfirmedToBookings < ActiveRecord::Migration[5.2]
  def change
    change_column :bookings, :payed, :boolean, :default => false
    change_column :bookings, :confirmed, :boolean, :default => false
  end
end
