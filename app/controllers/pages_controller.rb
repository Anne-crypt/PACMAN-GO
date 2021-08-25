class PagesController < ApplicationController
  def home
    @player = Player.new
    @game = Game.new
    @game.token = ("A".."Z").to_a.sample(4).join
    @game.save
  end

  def game
  end

end
