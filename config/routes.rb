Rails.application.routes.draw do
  get 'cartUpdate', to: 'carts#_cart'
  get 'carts', to: 'carts#show'
  get 'category/index'
  get 'products/index'
  get 'examples/index'
  post 'carts/add_item'
  post 'carts/remove'

  resources :order, only: [:new, :create]
  get '/shipping/new', to: 'shipping#new', as: 'new_shipping'
  post '/shipping', to: 'shipping#create', as: 'shipping'
  get '/shipping/success', to: 'shipping#success', as: 'success_shipping'




  root "landing#index"

  get "/home", to: "category#index"
  get "/products", to: "products#index"
  get '/products/new', to: 'products#new', as: 'new_product'
  post '/products', to: 'products#create', as: 'create_product'
  get '/products/:id', to: 'products#show', as: 'product'
  get '/products/:id/edit', to: 'products#edit', as: 'edit_product'

  get "/admin", to: "products#adminIndex"
  get "/admin/:id/edit", to: "products#edit"
  patch '/admin/:id/edit', to: 'products#update', as: 'update_product'
  delete "/admin/:id", to: "products#destroy", as: "destroy_admin_product"
  get "/admin/:id/delete", to: "products#delete_confirmation", as: "delete_confirmation_admin_product"
  
end
