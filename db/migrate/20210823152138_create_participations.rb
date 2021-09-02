class CreateParticipations < ActiveRecord::Migration[6.0]
  def change
    create_table :participations do |t|
      t.string :role, array: true, default: []
      t.boolean :is_winner, default: false
      t.string :state, array: true, default: []
      t.references :game, null: false, foreign_key: true
      t.references :players, null: false, foreign_key: true

      t.timestamps
    end
  end
end
