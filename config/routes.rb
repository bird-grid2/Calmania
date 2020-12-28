Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: "users/registrations",
    sessions: "users/sessions"
  }
  root to: "shows#index"
  post '/webhook', to: 'webhook#callback'

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
  
end