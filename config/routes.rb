Rails.application.routes.draw do
  
  devise_for :users
  root to: 'managements#index'

  resources :users, only: [:edit, :index, :update]
  resources :managements , only: :index, defaults: { format: 'json' }
  resources :graphs , only: :index, defaults: { format: 'json' }
  resources :logs, only: [ :new, :create, :index, :edit, :destroy, :update ] do
    resources :menus, only: [ :new, :create, :index, :edit, :update ] do
      resources :foods, only: [ :create, :index, :edit, :update ]
    end
  end
end