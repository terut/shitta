Shitta::Application.routes.draw do
  get 'signin' => "sessions#new"
  get 'signup' => "users#new"

  root :to => 'notes#index'

  resources :users
  resources :sessions
  resources :notes
  resources :services
end
