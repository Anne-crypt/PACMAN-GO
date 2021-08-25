class GamesController < ApplicationController

  def show
    @game = Game.find(params[:id])
    @ghosts = Participation.all.where(game_id: params[:id], role: 'ghost')
    @pacman = Participation.all.where(game_id: params[:id], role: 'pacman')
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
    # @game.player = current_user
    @players = Player.all
  end

private

  def player_params
    params.require(:game).permit(:lives, :token)
  end
end
