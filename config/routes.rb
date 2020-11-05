Rails.application.routes.draw do
  
  devise_for :users
  root to: 'shows#index'

  resources :users, except: [:index, :show]
  resources :managements, only: :index
  resources :shows, only: :index
  resources :graphs , only: :index
  resources :logs do
    resources :menus, only: :index
    collection do
      get :search
    end
  end

  resources :menus do
    resources :foods, only: :index
    collection do
      get :search
    end
  end
  
end