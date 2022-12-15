Rails.application.routes.draw do
  config = Rails.application.config.baukis2

  constraints host: config[:staff][:host] do
    namespace :staff, path: config[:staff][:path] do
      root "top#index"
      get "login" => "sessions#new"
      resource :session, only: [:create, :destroy]
      resource :account, except: [ :new, :create, :destroy ]
      resource :password, only: [:edit, :update]
    end
  end
  constraints host: config[:admin][:host] do
    namespace :admin, path: config[:admin][:path] do
      root "top#index"
      get "login" => "sessions#new"
      resource :session, only: [:create,:destroy]
      resources :staff_members, except: [:show] do
        resources :staff_events, only: [:index, :show]
      end
      resources :staff_events, only: [:index]
    end
  end

  constraints host: config[:customer][:host] do
    namespace :customer, path: config[:customer][:path] do
      root "top#index"
    end
  end
end
