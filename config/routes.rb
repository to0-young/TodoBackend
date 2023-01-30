Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :users, :tasks, :forget_passwords
      resource :sessions
    end
  end
end
