class PlayersController < ApplicationController

  def update
    @game          = Game.find(params[:game_id])
    @player        = Player.find(params[:id])
    @participation = @game.participations.find_by(player_id: @player.id)
    ghosts_participations = @game.participations.where(role: 'ghost')

    @player.latitude  = params[:latitude].to_f
    @player.longitude = params[:longitude].to_f
    @player.save!

    GameChannel.broadcast_to(@game, @player)

    if @participation.role == "pacman"
      items_nearby = Item.all.where(game_id: @game.id, eaten: false).near([@player.latitude, @player.longitude], 0.013)
      ghosts_nearby = @game.players.joins(:participations).where(participations: { role: 'ghost' }).near([@player.latitude, @player.longitude], 0.013).any? # distance: 1 meterµ

      if items_nearby.length > 0
       #   -> passer tous les items nearby à eaten true
       items_nearby.each do |item|
          item.eaten = true
          item.save
          @game.score += item.super ? 100 : 50
          @game.save
        end
        FoodChannel.broadcast_to(@game, [items_nearby, @game.score])
      end

      #   - ET si tous les items du game sont eaten true
      set_end_of_game([@participation]) if @game.finished == false && Item.all.where(game_id: @game.id, eaten: true).count == @game.items.length

      # - il y a un ghost nearby
      set_end_of_game(ghosts_participations) if ghosts_nearby && @game.finished == false

    else
      pacman_nearby = @game.players.joins(:participations).where(participations: {role: 'pacman'}).near([@player.latitude, @player.longitude], 0.025).any? # distance: 1 meter
      set_end_of_game(ghosts_participations) if pacman_nearby && @game.finished == false

    end
  end

  def create
    @player = Player.new(player_params)
    @player.latitude = rand(48.865171..48.865433)
    @player.longitude = rand(2.379320..2.379690)

    if @player.save
      session[:player_id] = @player.id

      if params['tokens']['token'].present?
        token = params['tokens']['token'].upcase
        @game = Game.where(token: token).first
      else
        @game = Game.new
        @game.token = ("A".."Z").to_a.sample(4).join
        @game.player = @player
        # raise
        @game.finished = false
        @game.save!
        set_items(@game)
      end

      if @game.nil?
          flash[:alert] = "OOPS! You added a non-valid token"
          redirect_to home_path
      else
        @participation = Participation.new(game_id: @game.id,
          player_id: @player.id,
          role: @game.player == current_player ? "pacman" : "ghost")
        if @participation.save
          # Broadcast action cable
          @game.participations.each do |participation|
            ParticipationChannel.broadcast_to(
              participation,
              render_to_string(partial: "players",
              locals: { receiver_participation: participation } )
            )
          end
          redirect_to edit_game_path(@game)
        else
          flash[:alert] = "OOPS! Party is already full (max 4 players)"
          redirect_to home_path
        end
      end
    else
      flash[:alert] = "OOPS! Something went wrong, try again! Make sure you enter a nickname"
      redirect_to home_path
    end
  end

  def new
    @player = Player.find(params[:player_id])
    @player = Player.new
  end

private

  def set_end_of_game(arrayofparticipants)
    @game.finished = true
        @game.save
        arrayofparticipants.each do |ghost_participation|
          ghost_participation.is_winner = true
          ghost_participation.save
        end
        GamestatusChannel.broadcast_to(@game, "finished")
  end

  def get_coords
    coords ="2.379421238301717 48.86582482888741
2.37951243340882 48.865704847973376
2.379587535260839 48.86560603994619
2.3796894592036324 48.865489587377425
2.3797699254740508 48.86538725004806
2.379850391744384 48.86527785474061
2.379300216962008 48.8659836267133"
    markers = coords.split("\n")
    return markers
  end

  def set_items(game)
    coords = get_coords()
    coords.each do |coord|
          coord = coord.split(" ")
          burgercount = game.items.where(super: true).count
          @game.items.create(
            eaten: false,
            latitude: coord.last.to_f,
            longitude: coord.first.to_f,
            super: burgercount <= 4 ? [true, false].sample : false
          )
      end
  end

  def player_params
    params.require(:player).permit(:nickname, :token, :tokens, :latitude, :longitude)
  end
end
