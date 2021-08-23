class CreatePlayers < ActiveRecord::Migration[6.0]
  def change
    create_table :players do |t|
      t.string :nickname
      t.float :longitude
      t.float :latitude
      t.string :color
      t.string :food_types, array: true, default: []

      t.timestamps
    end
  end
end
