Rails.application.routes.draw do
  get 'products_store/index'
  get 'products/index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root "products_store#index"
  resources :products_store
end
