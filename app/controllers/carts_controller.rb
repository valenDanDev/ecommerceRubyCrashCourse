class CartsController < ApplicationController
  # GET /carts
  def show
    @cart = current_cart
    @render_cart = false
  end

  # POST /carts/:id/add_item/:product_id
  def add_item
    @product = Product.find_by(id: params[:id])
    quantity = params[:quantity].to_i
    current_orderable = @cart.cart_items.find_by(product_id: @product.id)
    if current_orderable && quantity > 0
      current_orderable.update(quantity: quantity, subtotal: @product.price * quantity)
    elsif quantity <= 0
      current_orderable.destroy if current_orderable
    else
      @cart.cart_items.create(product: @product, quantity: quantity, subtotal: @product.price * quantity)
    end
  end

  def remove
    cart_item = CartItem.find_by(id: params[:id])
    cart_item.destroy if cart_item

    redirect_to products_path
  end

  private

  def cart_params
    params.require(:cart).permit(:total_items, :total_price)
  end
end
