class OrderController < ApplicationController
  def new
  @cart = current_cart
  @order = Order.create(status: "pending", total_price: @cart.total, order_date: Time.now)

  @cart.cart_items.each do |cart_item|
    OrderItem.create(
      order: @order,
      product: cart_item.product,
      quantity: cart_item.quantity,
      subtotal: cart_item.subtotal
    )
  end

  @cart.cart_items.destroy_all
  @cart.update(total_items: 0, total_price: 0)

  redirect_to new_shipping_path(order_id: @order.id), notice: 'Order was successfully created.'
end
end