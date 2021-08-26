class ItemsController < ApplicationController

  def new
    @game = Game.find(params[:game_id])
    @item = Item.new
  end

end
