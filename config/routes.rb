Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  namespace :api do
    namespace :v1 do
    #train

    #to fetch saved trains
    # get 'users/:id/trains', to: 'users#faveTrains'
    # get 'users/:id/locations', to: 'users#locations'
    # get 'train/:id', to: 'trains#show'
    # get 'directions', to: 'users#directions'
    # get 'user/:id/searches', to: 'users#savedSearches'

    resources :users do
    resources :fave_trains, only: [:index, :create, :show, :destroy]


    end





    end
  end
end
