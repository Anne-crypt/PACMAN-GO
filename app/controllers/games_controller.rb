class GamesController < ApplicationController

  def show
   @game = Game.find(params[:id])
   @current_player = Player.find(session[:player_id]) if session[:player_id]
  end

  def create
    @game = Game.new(game_params)
    game.token = [A..Z].sample(4)
    if @game.save
      redirect_to game_path
    else
      render :new
    end
  end

  def new
    @game = Game.new

    @players = Player.all
  end

private

  def player_params
    params.require(:game).permit(:lives, :token)
  end
end
