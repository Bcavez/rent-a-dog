class CreateDogs < ActiveRecord::Migration[5.2]
  def change
    create_table :dogs do |t|
      t.string :name
      t.string :race
      t.string :type
      t.text :description
      t.text :available
      t.string :image

      t.timestamps
    end
  end
end
