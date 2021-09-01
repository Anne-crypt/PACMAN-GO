class SettingsController < ApplicationController
  def edit
    @game = Game.find(params[:game_id])
    @player = current_player
  end

  def update
    @game = Game.find(params[:game_id])
    @player = current_player
    @player.update(color: params[:color])

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

    redirect_to edit_game_path(@game)
    # @participation = @game.participations.find_by(player: current_player)
    # @game.participations.update_all(role: 'ghost')


  end
end
