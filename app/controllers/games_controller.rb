class GamesController < ApplicationController
  before_action :authenticate_player

  def show
    @game = Game.find(params[:id])
    @players = @game.participations.map {|participation| participation.player}
    @markers = []

    @game.items.where(eaten: false).each_with_index do |item, index|

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
    @participation = @game.participations.find_by(player_id: current_player.id)

    # the below line retrieve the role of the current player
    # @current_role = @game.participations.find_by(player_id: @current_player.id).role

  end

  def update
    @game = Game.find(params[:id])
    @game.participations.update_all(role: 'ghost')

    Participation.find_by(game: params[:id], player_id: params["pacman"]).update(role: "pacman")

    @game.save
    respond_to do |format|
        format.html { redirect_to edit_game_path(@game) }
        format.json # Follow the classic Rails flow and look for a create.json view
    end

    # Broadcoast
    @game.participations.each do |participation|
      ParticipationChannel.broadcast_to(
        participation,
        render_to_string(partial: "players/players",
          locals: { receiver_participation: participation },
          formats: [:html]
        )
      )
    end
  end

  def start
    @game = Game.find(params[:id])
    GamestatusChannel.broadcast_to(@game, "start")
    redirect_to game_path(params[:id])
  end

  # def result
  #   @game = Game.find(params[:id])
  #   GamestatusChannel.broadcast_to(@game, "result")
  #   redirect_to game_path(params[:id])
  # end

  def new
    @game = Game.new
  end

private

  def player_params
    params.require(:game).permit(:token)
  end
end
