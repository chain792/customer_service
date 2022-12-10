Rails.application.routes.draw do
  devise_for :staff_members, path: 'staff', controllers: {
    sessions:      'staff/sessions',
    registrations: 'staff/registrations'
  }
  namespace :staff do
    root "top#index"
  end

  namespace :admin do
    root "top#index"
  end

  namespace :customer do
    root "top#index"
  end
end
