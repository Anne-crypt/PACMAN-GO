class PagesController < ApplicationController

  def home
    @player = Player.new
    @game = Game.new
    @game.token = ("A".."Z").to_a.sample(4).join #if @player == "host"
  end

  def game
  end
end
