Rails.application.routes.draw do

  namespace :api do
    namespace :v1 do
<<<<<<< HEAD
      get '/merchants/find', to: '/api/v1/merchants/search#show'
      resources :merchants, only: [:index, :show]
      resources :transactions, only: [:index, :show]
      resources :customers, only: [:index, :show]
    end
  end

=======
      resources :items, only: [:index, :show]
    end
  end
>>>>>>> master
end
