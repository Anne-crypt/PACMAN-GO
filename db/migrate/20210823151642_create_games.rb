class CreateGames < ActiveRecord::Migration[6.0]
  def change
    create_table :games do |t|
      t.float :start_latitude
      t.float :start_longitude
      t.string :token
      t.integer :lives
      t.boolean :finished
      t.references :player, null: false, foreign_key: true

      t.timestamps
    end
  end
end
