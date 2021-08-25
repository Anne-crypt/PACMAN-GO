class PlayersController < ApplicationController

  def create
    @player = Player.new(player_params)

    if @player.save!
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

      @participation = Participation.new(game_id: @game.id, player_id: @player.id, role: "ghost")
      @participation.save!
      redirect_to edit_game_path(@game.id)
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
    p params
    params.require(:player).permit(:nickname, :token, :tokens)
  end

end
