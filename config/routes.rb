Rails.application.routes.draw do
  require 'sidekiq/web'
  require 'sidekiq-status/web'
  mount Sidekiq::Web, at: "/sidekiq"
  post '/callback', to: 'webhook#callback'
  post '/send', to: 'webhook#broadcast'
  
  devise_for :users, controllers: {
    registrations: "api/v1/users/registrations",
    sessions: "api/v1/users/sessions"
  }

  root to: "api/v1/shows#index"
  
  namespace 'api' do
    namespace 'v1' do
      resources :users do
        resources :clock_work_events, except: [:index, :show]
      end

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
      get '/', to: 'shows#index'
      get '/management', to: 'shows#index'
      get '/menu', to: 'shows#index'
      get '/menu/:menuId/edit', to: 'shows#index'
      get '/log', to: 'shows#index'
      get '/log/:logId/edit', to: 'shows#index'
      get '/signIn', to: 'shows#index'
      get '/signUp', to: 'shows#index'
      get '/user/:userId/edit', to: 'shows#index'
      get '/graph', to: 'shows#index'
    end
  end
end