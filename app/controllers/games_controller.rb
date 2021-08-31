class GamesController < ApplicationController
  before_action :authenticate_player

  # COLORS = {
  #   red: ghost_red.png
  #   blue: ghost_blue.png
  #   orange: ghost_orange.png
  #   pink: ghost_pink.png
  #   green: ghost_green.png
  # }

  def show
    @game = Game.find(params[:id])
    @players = @game.participations.map {|participation| participation.player}
    @markers = []
    @game.items.each_with_index do |item, index|
    @markers << {
        lat: item.latitude,
        lng: item.longitude,
        image_url: item.super ? helpers.asset_url("burger.png") : helpers.asset_url("dot-test.png")
      }
    end
    @ghosts = Participation.all.where(game_id: params[:id], role: 'ghost')
    @pacman = Participation.all.where(game_id: params[:id], role: 'pacman')
    if @current_player.id != @pacman.first.player_id
      flash.now[:info] = 'Give pacman a little advantage'
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
