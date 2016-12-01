Rails.application.routes.draw do

  namespace :api do
    namespace :v1 do

      namespace :merchants do
        get '/revenue', to: '/api/v1/merchants/revenue#index'
        get '/most_revenue', to: '/api/v1/merchants/most_revenue#show'
        get '/find_all', to: '/api/v1/merchants/search#index'
        get '/find', to: '/api/v1/merchants/search#show'
        get '/random', to: '/api/v1/merchants/search#random'
        get '/most_items', to: '/api/v1/merchants/most_items#show'
      end
      resources :merchants, only: [:index, :show] do
        get '/favorite_customer', to: '/api/v1/merchants/favorite_customer#show'
        scope module: 'merchants' do
          resources :items, only: [:index]
          resources :invoices, only: [:index]
          get '/revenue', to: 'revenue#show'
        end
      end

      namespace :transactions do
        get '/find_all', to: '/api/v1/transactions/search#index'
        get '/random', to: '/api/v1/transactions/search#random'
        get '/find', to: '/api/v1/transactions/search#show'
      end
      resources :transactions, only: [:index, :show] do
        get '/invoice', to: '/api/v1/transactions/invoices#show'
      end

      namespace :customers do
        get '/find_all', to: '/api/v1/customers/search#index'
        get '/find', to: '/api/v1/customers/search#show'
        get '/random', to: '/api/v1/customers/search#random'
      end
      resources :customers, only: [:index, :show] do
        get '/favorite_merchant', to: '/api/v1/customers/favorite_merchants#show'
        scope module: 'customers' do
          resources :invoices, only: [:index]
          resources :transactions, only: [:index]
        end
      end

      namespace :items do
        get '/find_all', to: '/api/v1/items/search#index'
        get '/random', to: '/api/v1/items/search#random'
        get '/find', to: '/api/v1/items/search#show'
        get '/most_revenue', to: '/api/v1/items/most_revenue#show'
        get '/find_all', to: '/api/v1/items/search#index'
        get '/random', to: '/api/v1/items/search#random'
        get '/find', to: '/api/v1/items/search#show'
        get '/most_items', to: '/api/v1/items/most_items#show'
      end

      get '/items/:id/best_day', to: '/api/v1/items/best_day#show'

      resources :items, only: [:index, :show] do
        get 'invoice_item', to: '/api/v1/invoice_items#index'
        get '/merchant', to: '/api/v1/merchants#index'
      end

      namespace :invoices do
        get '/find_all', to: '/api/v1/invoices/search#index'
        get '/random', to: '/api/v1/invoices/search#random'
        get '/find', to: '/api/v1/invoices/search#show'
      end

      resources :invoices, only: [:index, :show] do
        scope module: 'invoices' do
          resources :transactions, only: [:index]
          resources :invoice_items, only: [:index]
          resources :items, only: [:index]
          get '/customer', to: 'customers#show'
          get '/merchant', to: 'merchants#show'
        end
      end

      namespace :invoice_items do
        get '/find_all', to: '/api/v1/invoice_items/search#index'
        get '/random', to: '/api/v1/invoice_items/search#random'
        get '/find', to: '/api/v1/invoice_items/search#show'
      end

      resources :invoice_items, only: [:index, :show] do
        get '/invoice', to: '/api/v1/invoices#index'
        get '/item', to: '/api/v1/items#index'
      end
    end
  end

end
