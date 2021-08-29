class SettingsController < ApplicationController
  def show
    @game = Game.find(params[:game_id])
    @player = current_player
    raise
  end
end
