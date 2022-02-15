Rails.application.routes.draw do
  resources :indices
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "indices#index"
end
