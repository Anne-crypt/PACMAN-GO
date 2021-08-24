class FixColumnNamePlayersId < ActiveRecord::Migration[6.0]
  def change
    rename_column :participations, :players_id, :player_id
  end
end
