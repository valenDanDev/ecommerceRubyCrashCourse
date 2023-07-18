Rails.application.routes.draw do
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
  get '/products/:id', to: 'products#show', as: 'product'
  get '/products/new', to: 'products#new', as: 'new_product'
  get '/products/:id/edit', to: 'products#edit', as: 'edit_product'
end
