class PlayersController < ApplicationController

  def update
    @game          = Game.find(params[:game_id])
    @player        = Player.find(params[:id])
    @participation = @game.participations.find_by(player_id: @player.id)

    @player.latitude  = params[:latitude].to_f
    @player.longitude = params[:longitude].to_f
    @player.save!

    GameChannel.broadcast_to(@game, @player)

    # LATER: gerer les vies
    # LATER: gérer le "timeout" des ghosts

    if @participation.role == "pacman"
      # items_nearby  = @game.items.near([@player.latitude, @player.longitude], 0.001) # distance: 1 meter
      items_not_eaten = Item.all.where(game_id: @game.id, eaten: false)
      items_nearby  = items_not_eaten.near([@player.latitude, @player.longitude], 0.05) # distance: 1 meter

      # ghosts_nearby = @game.participations.where(role: 'ghost').near([@player.latitude, @player.longitude], 0.001) # distance: 1 meter

      # - il y a des items neaby
      if items_nearby.length > 0
        #   -> passer tous les items nearby à eaten true
        items_nearby.each do |item|
          item.eaten = true
          item.save
          #   -> Ajouter une migration pour score
          #   -> augmenter le score
          # @game.score += 200

          # Broadcoast
          FoodChannel.broadcast_to(@game, item)
        end
      end

      #   - ET si tous les items du game sont eaten true
     if @game.finished == false && Item.all.where(game_id: @game.id, eaten: true).count == @game.items.length
      #   -> fin du jeu, pacman loses
      @game.finished = true
      @game.save
      #   -> passer participation is winner
      @participation.is_winner = true
      @participation.save
      #   -> broadcaster la fin du jeu sur le gamestatus channel
      # redirect_to result_game_path(@game)
      GamestatusChannel.broadcast_to(@game, "finished")
      # flash.now[:info] = "You win!"
      # render # popup => new route => pages/game/game_id/result"
     end

      # CASES
      # - il y a des items neaby
      #   -> passer tous les items nearby à eaten true
      #   -> augmenter le score
      #   -> broadcaster le retrait de l'item
      #   - ET si tous les items du game sont eaten true
      #     -> fin du jeu, pacman wins
      #     -> passer participation is winner true ET game finished true
      #     -> broadcaster la fin du jeu sur le gamestatus channel
      # - il y a un ghost nearby
      #   -> fin du jeu, pacman loses
      #   -> passer participation is winner false ET game finished true
      #   -> passer toutes les participations ghost is winner true
      #   -> broadcaster la fin du jeu sur le gamestatus channel

    else
      # pacman_nearby = @game.participations.where(role: 'pacman').near([@player.latitude, @player.longitude], 0.001) # distance: 1 meter




      # CASES
      # - il y a le pacman nearby
      #   -> fin du jeu, pacman loses
      #   -> broadcaster la fin du jeu sur le gamestatus channel
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
        coords = [[48.866089, 2.379206], [48.865979, 2.379292], [48.864892, 2.379984], [48.865792, 2.379437], [48.865644, 2.379550],
      [48.865475, 2.379684], [48.865323, 2.379829],
      [48.865210, 2.379925], [48.865115, 2.380001], [48.865009, 2.380081],
      [48.864903, 2.380183], [48.864822, 2.380248]]
        coords.each do |coord|
          burgercount = @game.items.where(super: true).count
          @game.items.create(
            eaten: false,
            latitude: coord.first,
            longitude: coord.last,
            super: burgercount <= 3 ? [true, false].sample : false
          )
        end
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
      flash[:alert] = "OOPS! Something went wrong, try again! Make sure "
      redirect_to home_path
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
