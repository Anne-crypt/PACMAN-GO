class SettingsController < ApplicationController
  def edit
    @game = Game.find(params[:game_id])
    @player = current_player
    # raise
  end
end
