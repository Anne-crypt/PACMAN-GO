class ApplicationController < ActionController::Base
  def current_player

    # ||= signifie "ou égal" équivaut à @current_player = @current_player || do_somenthing
    # la méthode va associer le user connecté à la variable current_player
    # Cette méthode s'appelle de la mémoisation
    # On pourra garder cette méthode
    if session[:player_id]
      @current_player ||= Player.find(session[:player_id])
    end

    # To activate only if you want to log as Host
    # Player.find_by(nickname: "Anne")
  end

  helper_method :current_player
end
