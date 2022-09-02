Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      get '/merchants/find', to: 'merchants/search#find_merchant'
      get '/items/find_all', to: 'items/search#find_items'
      resources :merchants, only: [:index, :show] do 
        resources :items, only: [:index], to: 'merchant_items#index'
      end
      resources :items, only: [:index, :show, :create, :update, :destroy] do 
        get '/merchant', only: [:show], to: 'items_merchant#show'
      end
    end
  end
end
