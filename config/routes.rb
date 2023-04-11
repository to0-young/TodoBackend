Rails.application.routes.draw do
  mount ActionCable.server => '/cable'

  resources :messages
  namespace :api do
    namespace :v1 do
      resources :users, :tasks, :forget_passwords
      resource :sessions, :users
    end
  end
end
