Rails.application.routes.draw do

  namespace :api do
    namespace :v1 do

      namespace :items do
        get '/', to: 'items#index'
        post '/', to: 'items#create'
        get '/:item_id', to: 'items#show'
        patch '/:item_id', to: 'items#update'
        delete '/:item_id', to: 'items#destroy'
        get '/:item_id/merchant', to: 'items_merchant#index'
      end

      namespace :merchants do
        get '/', to: 'merchants#index'
        post '/', to: 'merchants#create'
        get '/:merchant_id', to: 'merchants#show'
        put '/:merchant_id', to: 'merchants#update'
        delete '/:merchant_id', to: 'merchants#destroy'
        get '/:merchant_id/items', to: 'merchant_items#index'
      end
    end
  end
end
