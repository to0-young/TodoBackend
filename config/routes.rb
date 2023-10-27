Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  mount ActionCable.server => '/cable'
  ActiveAdmin.routes(self)

  resources :messages, only: [:index, :create, :destroy]
  namespace :api do
    namespace :v1 do
      resources :users, :tasks, :forget_passwords
      resource :sessions, :users
    end
  end
end
