class CartsController < ApplicationController
    # GET /carts
    def show
      @render_cart = false
    end
  
    # POST /carts/:id/add_item/:product_id
    def add_item
      @product = Product.find_by(id: params[:id])
      quantity = params[:quantity].to_i
      current_orderable = @cart.cart_items.find_by(product_id: @product.id)
      if current_orderable && quantity > 0
        puts "ACTUALIZAR carro"
        current_orderable.update(quantity: quantity, subtotal: @product.price * quantity)
      elsif quantity <= 0
        puts "NO crear nuevo carro"
        current_orderable.destroy if current_orderable
      else
        puts "crear nuevo carro"
        @cart.cart_items.create(product: @product, quantity: quantity, subtotal: @product.price * quantity)
      end
  
      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: [turbo_stream.replace('cart',
                                                     partial: 'carts/cart',
                                                     locals: { cart: @cart }),
                                turbo_stream.replace(@product)]
        end
      end
    end
    
    def remove
      cart_item = CartItem.find_by(id: params[:id])
      cart_item.destroy if cart_item
    
      @cart.reload  # Reload the @cart object to reflect the changes
    
      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: turbo_stream.replace('cart',
                                                    partial: 'carts/cart',
                                                    locals: { cart: @cart })
        end
      end
    end
    
      
  
    private
  
    def cart_params
      params.require(:cart).permit(:total_items, :total_price)
    end
  end
  