class SignedInConstraint
  def self.matches?(request)
    !request.session[:user_id].blank?
  end
end

Shitta::Application.routes.draw do
  get 'signin' => 'sessions#new'
  get 'signup' => 'users#new'
  get 'signout' => 'sessions#destroy'

  root to: 'notes#index', constraints: SignedInConstraint, as: :authenticated_root
  root to: 'sessions#welcome'

  resources :users
  resources :notes do
    member do
      post :share
    end
    resources :comments, only: [:index, :create]
  end

  resources :comments, except: [:index, :create]

  scope 'settings' do
    resources :services
  end
  resources :sessions
end
