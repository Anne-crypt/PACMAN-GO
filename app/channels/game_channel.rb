class GameChannel < ApplicationCable::Channel
  def subscribed
    # stream_from "some_channel"
    game = Game.find(params[:id])
    stream_for game
  end
end
