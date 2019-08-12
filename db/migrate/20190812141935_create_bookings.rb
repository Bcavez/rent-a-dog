class CreateBookings < ActiveRecord::Migration[5.2]
  def change
    create_table :bookings do |t|
      t.text :description
      t.string :date
      t.boolean :payed
      t.boolean :confirmed

      t.timestamps
    end
  end
end
