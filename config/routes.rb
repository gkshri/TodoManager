Rails.application.routes.draw do
  # get "todos", to: "todos#index"
  # post "todos/create", to: "todos#create"
  # get "todos/:id", to: "todos#show"

  get "/" => "home#index"

  get "users/login", to: "users#login"
  resources :todos, :users

  get "/signin" => "sessions#new", as: :new_sessions
  post "/signin" => "sessions#create", as: :sessions
  delete "/signout" => "sessions#destroy", as: :destroy_session
end