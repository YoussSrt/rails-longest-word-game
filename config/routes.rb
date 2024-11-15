Rails.application.routes.draw do
  get 'games/new'
  get 'games/score'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check
  # Route pour afficher la page avec les lettres
  get '/new', to: 'games#new', as: 'new_game'

  # Route pour soumettre le mot et afficher le score
  post '/score', to: 'games#score', as: 'score_game'

  # Définir la page d'accueil sur la page new
  root to: 'games#new'
  # Defines the root path route ("/")
  # root "posts#index"
end
