class SignedInConstraint
  def self.matches?(request)
    !request.session[:user_id].blank?
  end
end

Shitta::Application.routes.draw do
  resources :comments


  get 'signin' => 'sessions#new'
  get 'signup' => 'users#new'
  get 'signout' => 'sessions#destroy'

  root to: 'notes#index', constraints: SignedInConstraint
  root to: 'sessions#welcome'

  resources :users
  resources :notes

  scope 'settings' do
    resources :services
  end
  resources :sessions
end
