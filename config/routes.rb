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
  root "products#index"
  resources :products 
  #post 'add_item/:product_id', to: 'carts#add_item', as: 'add_item_cart'

  

end
