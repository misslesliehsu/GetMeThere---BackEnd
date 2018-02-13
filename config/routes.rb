Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  namespace :api do
    namespace :v1 do

    resources :users do
    resources :fave_trains, only: [:index, :create, :show, :destroy]
      end
    end
  end

  post "/login", to: 'auth#login'
  get "/current_user", to: "auth#currentUser"

end
