Rails.application.routes.draw do
  resources :indices
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "indices#index"
  post 'webhook', to: "indices#webhook"
  post 'customer_create', to: "indices#create_customer" 
end
