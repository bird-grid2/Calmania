Rails.application.routes.draw do
  require 'sidekiq/web'
  require 'sidekiq-status/web'
  mount Sidekiq::Web, at: "/sidekiq"

  devise_for :users, controllers: {
    registrations: "users/registrations",
    sessions: "users/sessions"
  }

  resources :users do
    resources :clock_work_events, except: [:index, :show]
  end
  root to: "shows#index"
  post '/callback', to: 'webhook#callback'
  post '/send', to: 'webhook#broadcast'
  get '/management', to: 'shows#index'
  get '/menu', to: 'shows#index'
  
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