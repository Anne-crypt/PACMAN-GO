class ApplicationController < ActionController::Base
  def current_player

    # ||= signifie "ou égal" équivaut à @current_player = @current_player || do_somenthing
    # la méthode va associer le user connecté à la variable current_player
    # Cette méthode s'appelle de la mémoisation
    # # On pourra garder cette méthode
    # if session[:player_id]
    #   @current_player ||= Player.find_by(id: session[:player_id])
    # end

    # To activate only if you want to log as Host
    Player.find_by(nickname: "Anne")
  end
  # Ce helper permet que le current player dans les views
  # /!\ A garder sous la methode current_player
  helper_method :current_player

  def authenticate_player
    if current_player.nil?
      redirect_to root_path
    end
  end

end
