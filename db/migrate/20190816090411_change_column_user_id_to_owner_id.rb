class ChangeColumnUserIdToOwnerId < ActiveRecord::Migration[5.2]
  def change
    rename_column :dogs, :user_id, :owner_id
  end
end
