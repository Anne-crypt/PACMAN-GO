class GamesController < ApplicationController
  before_action :authenticate_player

  def show
    @game = Game.find(params[:id])
    @players = @game.participations.map {|participation| participation.player}
    @markers = []
    @current_player_participation = @game.participations.find_by(player_id: current_player.id)
    @items = @game.items.where(eaten: false)
    @pacman = Participation.all.where(game_id: params[:id], role: 'pacman').first

    flash.now[:info] = 'Give pacman a little advantage' unless @current_player.id == @pacman.player_id || @game.finished
  end

  def edit
    @game = Game.find(params[:id])
    @participation = @game.participations.find_by(player_id: current_player.id)
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


private

  def player_params
    params.require(:game).permit(:token)
  end
end
