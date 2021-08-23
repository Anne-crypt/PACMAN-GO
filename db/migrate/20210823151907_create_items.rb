class CreateItems < ActiveRecord::Migration[6.0]
  def change
    create_table :items do |t|
      t.boolean :eaten
      t.boolean :super
      t.float :longitude
      t.float :latitude
      t.references :game, null: false, foreign_key: true

      t.timestamps
    end
  end
end
