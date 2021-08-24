Rails.application.routes.draw do
  root to: 'pages#landing'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get 'home', to: 'pages#home'
  resources :games, only: [:show, :create, :new]
  resources :player, only: [:create, :new]
end
