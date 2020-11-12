Rails.application.routes.draw do
  
  devise_for :users
  root to: 'shows#index'

  resources :users, except: [:index, :show]
  resources :managements, only: :index
  resources :shows, only: :index
  resources :graphs , only: :index
  resources :logs, except: :show do
    resources :menus, only: :index
    collection do
      get :search
      get :dsearch
    end
  end

  resources :menus, except: :show do
    resources :foods, only: :index
    collection do
      get :search
    end
  end

  post '/callback', to: 'webhook#callback'
  
end