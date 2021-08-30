class SettingsController < ApplicationController
  def edit
    @game = Game.find(params[:game_id])
    @player = current_player
  end

  def update
    @game = Game.find(params[:game_id])
    @player = current_player
    @player.update(color: params[:color])
    redirect_to edit_game_path(@game)
    # @participation = @game.participations.find_by(player: current_player)
    # @game.participations.update_all(role: 'ghost')
  end
end
