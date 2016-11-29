Rails.application.routes.draw do

  namespace :api do
    namespace :v1 do
      get '/merchants/find', to: '/api/v1/merchants/search#show'
      get '/invoice_items/find', to: '/api/v1/invoice_items/search#show'
      get '/items/find', to: '/api/v1/items/search#show'
      get '/invoices/find', to: '/api/v1/invoices/search#show'
      get '/transactions/find', to: '/api/v1/transactions/search#show'
      get '/customers/find', to: '/api/v1/customers/search#show'
      resources :merchants, only: [:index, :show]
      resources :transactions, only: [:index, :show]
      resources :customers, only: [:index, :show]
      resources :items, only: [:index, :show]
      resources :invoices, only: [:index, :show]
      resources :invoice_items, only: [:index, :show]
    end
  end

end
