class PagesController < ApplicationController

  def home
    @player = Player.new
    @game = Game.new
  end
end
