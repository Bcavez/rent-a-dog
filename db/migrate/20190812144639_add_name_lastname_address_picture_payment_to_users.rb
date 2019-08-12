class AddNameLastnameAddressPicturePaymentToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :name, :string
    add_column :users, :lastname, :string
    add_column :users, :address, :string
    add_column :users, :picture, :string
    add_column :users, :payment, :string
  end
end
