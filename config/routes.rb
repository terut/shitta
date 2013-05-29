class SignedInConstraint
  def self.matches?(request)
    !request.session[:user_id].blank?
  end
end

Shitta::Application.routes.draw do
  get 'signin' => 'sessions#new'
  get 'signup' => 'users#new'
  get 'signout' => 'sessions#destroy'

  root to: 'notes#index', constraints: SignedInConstraint
  root to: 'sessions#welcome'

  resources :users
  resources :notes do
    member do
      post :share
    end
    resources :comments, only: [:index, :create]
  end

  resource :comments, except: [:index, :create]

  scope 'settings' do
    resources :services
  end
  resources :sessions
end
