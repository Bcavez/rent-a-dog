class RenameTypeToDogs < ActiveRecord::Migration[5.2]
  def change
     rename_column :dogs, :type, :size
  end
end
