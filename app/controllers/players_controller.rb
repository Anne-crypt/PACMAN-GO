class PlayersController < ApplicationController

  def create
    @player = Player.new(player_params)
    @player.player = current_user
    if @player.save
      redirect_to players_path
    else
      render :new
    end
  end

  def new
    @player = Player.find(params[:player_id])
    @player = Player.new
  end

private

  def player_params
    params.require(:player).permit(:nickname)
  end

end
