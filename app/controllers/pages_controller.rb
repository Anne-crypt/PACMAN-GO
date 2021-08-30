class PagesController < ApplicationController

  def home
    @player = Player.new
    @game = Game.new
  end

  def game
  end
end
