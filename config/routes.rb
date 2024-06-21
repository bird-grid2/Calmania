Rails.application.routes.draw do
  require 'sidekiq/web'
  require 'sidekiq-status/web'
  mount Sidekiq::Web, at: "/sidekiq"
  root to: "api/v1/shows#index"

  devise_for :users, controllers: { registrations: "users/registrations", sessions: "users/sessions" }, defaults: { format: :json }

  devise_scope :user do
    get "/users/sign_up", to: "users/registrations#new", defaults: { format: :json }
    post "/users/create", to: "users/registrations#create", defaults: { format: :json }
    get "/user/load_data", to: "users/registrations#load_data", defaults: { format: :json }
    patch "/user/:id/update", to: "users/registrations#update", defaults: { format: :json }
    delete "/user/:id/delete", to: "users/registrations#destroy", defaults: { format: :json }
  end

  resources :users, only: [], defaults: { format: :json }  do
    resources :clock_work_events, except: [:index, :show]
  end

  namespace 'api', defaults: { format: :json } do
    namespace 'v1' do
      post '/callback', to: 'webhook#callback'
      post '/send', to: 'webhook#broadcast'
      
      resources :managements, only: :index
      resources :shows, only: :index
      resources :graphs , only: :index
      resources :logs, except: :show do
        collection do
          get :edit
          get :menu_data
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
          get :new
        end
      end

      match '*path', to: 'application#response_not_found', via: :all
    end
  end
end