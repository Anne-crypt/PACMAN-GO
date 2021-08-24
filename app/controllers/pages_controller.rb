class PagesController < ApplicationController
  def home
    @player = Player.new
  end

  def game
  end
end
