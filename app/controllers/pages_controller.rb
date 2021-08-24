class PagesController < ApplicationController
  def home
    @player = Player.new
  end
end
