Rails.application.routes.draw do
  
  devise_for :users
  root to: 'managements#index'

  resources :users, except: [:index, :show]
  resources :managements , only: :index
  resources :graphs , only: :index  #, defaults: { format: 'json' }
  resources :logs, except: :show
  resources :menus do
    resources :foods, only: :index
    collection do
      get :search
    end
  end
end