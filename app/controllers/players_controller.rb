class PlayersController < ApplicationController

  def create
    @player = Player.new(player_params)
    @player.latitude = rand(48.865171..48.865433)
    @player.longitude = rand(2.379320..2.379690)

    if @player.save
      session[:player_id] = @player.id
      if params['tokens']['token'].present?
        token = params['tokens']['token']
        @game = Game.where(token: token).first
      else
        @game = Game.new
        @game.token = ("A".."Z").to_a.sample(4).join
        @game.player = @player
        @game.save!
      end

      @participation = Participation.new(game_id: @game.id,
        player_id: @player.id,
        role: @game.player == current_player ? "pacman" : "ghost")
      @participation.save!
      # Broadcast action cable
      redirect_to edit_game_path(@game.id)
    else
      render "pages/home"
    end
  end

  def new
    @player = Player.find(params[:player_id])
    @player = Player.new
  end

private

  def player_params
    params.require(:player).permit(:nickname, :token, :tokens, :latitude, :longitude)
  end

end
