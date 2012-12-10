Shitta::Application.routes.draw do
  resources :users

  root :to => 'users#signin'
end
