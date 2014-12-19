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

  resources :users, only: [:show, :create]
  resources :notes do
    member do
      post :share
    end
    resources :comments, only: [:index, :create]
    resources :favorites, only: [:create, :destroy]
  end

  resources :tags, only: [:show] do
    collection do
      get :autocomplete
    end
  end

  resources :comments, except: [:index, :create]

  scope 'settings' do
    resources :services
    get 'account' => 'users#edit'
    patch 'account' => 'users#update'
    put 'account' => 'users#update'
  end

  scope 'search' do
    get 'notes' => 'notes#search', as: :search_notes
  end

  resources :sessions
#  resources :sessions do
#    collection do
#      get 'forgot_password' => 'password_resets#new'
#      post 'forgot_password' => 'password_resets#create'
#      get 'reset_password/:token' => 'password_resets#edit'
#      put 'reset_password/:token' => 'password_reset#update'
#    end
#  end

  resources :password_resets
end
