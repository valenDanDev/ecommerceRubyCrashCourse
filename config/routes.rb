Rails.application.routes.draw do
  get 'carts', to: 'carts#show'
  get 'category/index'
  get 'products/index'
  get 'examples/index'
  post 'carts/add_item'
  post 'carts/remove'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  #get "/", to: "landing#index"
  root "landing#index"
  #resources :landing
  #post 'add_item/:product_id', to: 'carts#add_item', as: 'add_item_cart'

  get "/home", to: "category#index"
  get "/products", to: "products#index"
  get '/products/:id', to: 'products#show', as: 'product'
  get '/products/new', to: 'products#new', as: 'new_product'
  get '/products/:id/edit', to: 'products#edit', as: 'edit_product'


end
