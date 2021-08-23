Rails.application.routes.draw do
  root to: 'pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :games, only: [:show, :create, :new]
  resources :player, only: [:create, :new]
end
