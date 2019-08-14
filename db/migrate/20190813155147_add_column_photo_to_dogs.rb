class AddColumnPhotoToDogs < ActiveRecord::Migration[5.2]
  def change
    add_column :dogs, :photo, :string
  end
end
