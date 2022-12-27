Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :users
      resource :sessions
    end
  end
end
