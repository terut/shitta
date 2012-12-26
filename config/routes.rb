class SignedInConstraint
  def self.matches?(request)
    request.cookies.key?('user_token')
  end
end

Shitta::Application.routes.draw do
  get 'signin' => "sessions#new"
  get 'signup' => "users#new"

  root to: 'notes#index', constraints: SignedInConstraint
  root to: 'sessions#welcome'

  resources :users
  resources :notes
  resources :services
  resources :sessions
end
