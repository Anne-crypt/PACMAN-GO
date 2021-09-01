Rails.application.routes.draw do
  root to: 'pages#landing'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get 'home', to: 'pages#home'
  resources :games, only: [:show, :create, :new, :edit, :update] do
    resources :items, only: :create
    resource :settings, only: [:edit, :update]

    member do
      post 'start'
    end

    member do
      post 'result'
    end
  end

  resources :players, only: [:create, :new]

  patch '/games/:game_id/players/:id', to: 'players#update'

end
