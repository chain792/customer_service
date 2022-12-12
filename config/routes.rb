Rails.application.routes.draw do
  namespace :staff do
    root "top#index"
    get "login" => "sessions#new"
    resource :session, only: [:create, :destroy]
  end

  namespace :admin do
    root "top#index"
    get "login" => "sessions#new"
    resource :session, only: [:create,:destroy]
  end

  namespace :customer do
    root "top#index"
  end
end
