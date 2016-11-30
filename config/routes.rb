Rails.application.routes.draw do

  namespace :api do
    namespace :v1 do
      get '/merchants/find_all', to: '/api/v1/merchants/search#index'
      get '/merchants/find', to: '/api/v1/merchants/search#show'
      get '/merchants/random', to: '/api/v1/merchants/search#random'

      get '/invoice_items/find_all', to: '/api/v1/invoice_items/search#index'
      get '/invoice_items/find', to: '/api/v1/invoice_items/search#show'
      get '/invoice_items/random', to: '/api/v1/invoice_items/search#random'

      get '/items/find_all', to: '/api/v1/items/search#index'
      get '/items/find', to: '/api/v1/items/search#show'
      get '/items/random', to: '/api/v1/items/search#random'

      get '/invoices/find_all', to: '/api/v1/invoices/search#index'
      get '/invoices/find', to: '/api/v1/invoices/search#show'
      get '/invoices/random', to: '/api/v1/invoices/search#random'

      get '/transactions/find_all', to: '/api/v1/transactions/search#index'
      get '/transactions/find', to: '/api/v1/transactions/search#show'
      get '/transactions/random', to: '/api/v1/transactions/search#random'

      get '/customers/find', to: '/api/v1/customers/search#show'

      resources :merchants, only: [:index, :show] do
        scope module: 'merchants' do
          resources :items, only: [:index]
          resources :invoices, only: [:index]
          get '/revenue', to: 'revenue#show'
        end
      end
      resources :transactions, only: [:index, :show]
      resources :customers, only: [:index, :show]
      resources :items, only: [:index, :show]
      resources :invoices, only: [:index, :show] do
        scope module: 'invoices' do
          resources :transactions, only: [:index]
          resources :invoice_items, only: [:index]
          resources :items, only: [:index]
          get '/customer', to: 'customers#show'
          get '/merchant', to: 'merchants#show'
        end
      end
      resources :invoice_items, only: [:index, :show]
    end
  end

end
