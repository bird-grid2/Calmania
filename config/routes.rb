Rails.application.routes.draw do
  
  devise_for :users
  root to: 'managements#index'

  resources :users, only: [:edit, :index, :update]
  resources :managements , only: :index  #, defaults: { format: 'json' }
  resources :graphs , only: :index  #, defaults: { format: 'json' }
  resources :logs, except: :show do
    
    member do
      get :edit
    end
  end
  resources :menus do
    resources :foods, only: :index
    collection do
      get :search
    end
  end
end