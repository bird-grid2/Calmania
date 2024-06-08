Rails.application.routes.draw do
  require 'sidekiq/web'
  require 'sidekiq-status/web'
  mount Sidekiq::Web, at: "/sidekiq"
  root to: "api/v1/shows#index"
  
 

  namespace 'api', defaults: { format: :json } do
    namespace 'v1' do
      post '/callback', to: 'webhook#callback'
      post '/send', to: 'webhook#broadcast'
      
      devise_for :users, controllers: { registrations: "api/v1/users/registrations", sessions: "api/v1/users/sessions" }

      devise_scope :api_v1_user do
        get "/sign_up", to: "users/registrations#new"
        post "/user/create", to: "users/registrations#create"
        get "/user/load_data", to: "users/registrations#load_data"
        patch "/user/:id/update", to: "users/registrations#update"
        delete "/user/:id/delete", to: "users/registrations#destroy"
      end

      resources :users, only: [] do
        resources :clock_work_events, except: [:index, :show]
      end

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