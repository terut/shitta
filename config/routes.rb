Shitta::Application.routes.draw do
  get 'signin' => "sessions#new"
  get 'signup' => "users#new"

  root :to => 'sessions#new'

  resources :users
  resources :sessions
  resources :notes
end
