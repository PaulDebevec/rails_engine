Rails.application.routes.draw do

  namespace :api do
    namespace :v1 do
      resources :merchants, only: [:index, :show, :create, :update, :destroy]
      resources :items, only: [:index, :show, :create, :update, :destroy]
      get '/merchants/:merchant_id/items', to: 'merchant_items#index'
      get '/items/:item_id/merchant', to: 'items_merchant#index'
    end
  end
end
