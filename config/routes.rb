Rails.application.routes.draw do
  require 'sidekiq/web'
  require 'sidekiq-status/web'
  mount Sidekiq::Web, at: "/sidekiq"
  post '/callback', to: 'webhook#callback'
  post '/send', to: 'webhook#broadcast'

  root to: "api/v1/shows#index"

  namespace 'api', defaults: { format: :json } do
    namespace 'v1' do
      devise_for :users, controllers: {
        registrations: "api/v1/users/registrations",
        sessions: "api/v1/users/sessions"
      }

      resources :users do
        resources :clock_work_events, except: [:index, :show]
      end

      resources :managements, only: :index
      resources :shows, only: :index
      resources :graphs , only: :index
      resources :logs, except: :show do
        collection do
          get :edit
          post :search
          post :dsearch
        end
      end
    
      resources :menus, except: :show do
        resources :foods, only: :index
        collection do
          post :search
          get :edit
          get :food_data
        end
      end

      get '/', to: 'api/v1/shows#index'
      get '/management', to: 'api/v1/shows#index'
      get '/menus', to: 'api/v1/shows#index'
      get '/menu/:menuId/edit', to: 'api/v1/shows#index'
      get '/log', to: 'api/v1/shows#index'
      get '/log/:logId/edit', to: 'api/v1/shows#index'
      get '/signIn', to: 'api/v1/shows#index'
      get '/signUp', to: 'api/v1/shows#index'
      get '/user/:userId/edit', to: 'api/v1/shows#index'
      get '/graph', to: 'api/v1/shows#index'
      get '/menus/new', to: 'menus#new'
    end
  end
end