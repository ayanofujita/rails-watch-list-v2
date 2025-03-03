Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  root "pages#home"

  post "/movies/fetch_movie", to: "movies#fetch_movie"
  post "/movies/fetch_movie_info", to: "movies#fetch_movie_info"

  get "/movies", to: "movies#index"

  resources :lists do
    resource :favorite, only: [:create, :destroy]
  end

  delete "lists/:list_id/movies/:id", to: "lists#movie_destroy", as: "list_movie"

end
