Rails.application.routes.draw do
  get 'category/index'
  get 'products/index'
  get 'examples/index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root "products#index"
  resources :products
end
