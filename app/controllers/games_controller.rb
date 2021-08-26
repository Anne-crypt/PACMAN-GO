class GamesController < ApplicationController
  before_action :authenticate_player

  def show
    @game = Game.find(params[:id])
  #  @game = Game.find(params[:id])
  #  @current_player = Player.find(session[:player_id]) if session[:player_id]
    @players = @game.participation.map { |participation| participation.player}
     @markers = @players.map do |player|
      {
        lat: player.latitude,
        lng: player.longitude,
        image_url: helpers.asset_url('https://placekitten.com/200/300')
      }
    end
  end

  def create
    @game = Game.new(game_params)
    game.token = [A..Z].sample(4)
    if @game.save
      redirect_to edit_game_path(@game)
    else
      render :new
    end
  end

  def edit
    @game = Game.find(params[:id])
    # @current_player = Player.find_by(id: session[:player_id]) if session[:player_id]
    # current_player
  end

  def update
    @game = Game.find(params[:id])
    @game.participations.update_all(role: 'ghost')
    Participation.find_by(game: params[:id], player_id: params["player"]["pacman"]).update(role: "pacman")
    # raise
    redirect_to game_path(params[:id])
  end

  def new
    @game = Game.new
  end

private

  def player_params
    params.require(:game).permit(:token)
  end
end
