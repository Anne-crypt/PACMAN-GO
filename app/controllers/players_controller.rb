class PlayersController < ApplicationController

  # GameChannel.braodcast_to(@game, render_to_string(partial: "userplayer" )
  def update
    @game = Game.find(params[:game_id])
    @player = Player.find(params[:id])
    @player.latitude = params[:latitude].to_f
    @player.longitude = params[:longitude].to_f
    @player.save!
    GameChannel.broadcast_to(@game, @player)
  end

  def create

    @player = Player.new(player_params)
    # Here we need to capture the location by JS
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
        coords = [[48.866089, 2.379206], [48.865979, 2.379292], [48.864892, 2.379984], [48.865792, 2.379437], [48.865644, 2.379550],
      [48.865475, 2.379684], [48.865323, 2.379829],
      [48.865210, 2.379925], [48.865115, 2.380001], [48.865009, 2.380081],
      [48.864903, 2.380183], [48.864822, 2.380248]]
        coords.each do |coord|
          burgercount = @game.items.where(super: true).count
          @game.items.create(latitude: coord.first, longitude: coord.last, super: burgercount <= 3 ? [true, false].sample : false)
        end
      end

      @participation = Participation.new(game_id: @game.id,
        player_id: @player.id,
        role: @game.player == current_player ? "pacman" : "ghost")
      @participation.save!
      # Broadcast action cable
      GameChannel.broadcast_to(
       @game,
        render_to_string(partial: "players")
      )

    else
      render "pages/home"
    end
  end

  def new
    @player = Player.find(params[:player_id])
    @player = Player.new
  end

  def update
    # Update du player (code Dorien)

    # if player is pacman
    #   @player.game.items.near([@player.latitude, @player.longitude], 4, units: :m)
    # end

    # Call Websocket pour envoyer l'infos les positions (pacma, ghosts, items.where(eaten: false))
  end

private

  def player_params
    params.require(:player).permit(:nickname, :token, :tokens, :latitude, :longitude)
  end


end
