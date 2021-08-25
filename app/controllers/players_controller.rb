class PlayersController < ApplicationController

  def create
    @player = Player.new(player_params)
    if params[:type] == "guest"

    end

    if @player.save
      session[:player_id] = @player.id
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
