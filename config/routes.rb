Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1, defaults: { format: :json } do
      root 'root#index'
      resources :accounts do
        resources :account_transactions, only: [:index, :create]
      end

      resources :account_transactions, except: [:create]

      # resources :transactions
    end
  end
end
