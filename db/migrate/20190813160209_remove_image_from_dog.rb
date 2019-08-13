class RemoveImageFromDog < ActiveRecord::Migration[5.2]
  def change
    remove_column :dogs, :image, :string
  end
end
