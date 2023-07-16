Rails.application.routes.draw do
  get 'category/index'
  get 'products/index'
  get 'examples/index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root "category#index"
  resources :category
  post 'add_item/:product_id', to: 'carts#add_item', as: 'add_item_cart'
  get "/products", to: "products#index"
    # get '/categories/:category', to: 'products#index', as: 'category'

end
