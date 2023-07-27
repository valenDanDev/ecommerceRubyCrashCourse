class ShippingController < ApplicationController
  def new
    @order = Order.find(params[:order_id])
    @order_items = @order.order_items
    @shipping = Shipping.new
  end

  def create
    @shipping = Shipping.new(shipping_params)

    if @shipping.save
      # Update the associated order status to "completed"
      order = Order.find_by(id: params[:order_id])
      order.update(status: "completed") if order

      redirect_to success_shipping_path(order_id: @shipping.order_id)
    else
      puts "error"
    end
  end

  def success
    @shipping = Shipping.find_by(order_id: params[:order_id])
    @order = Order.find_by(id: params[:order_id])
  end

  private
  def shipping_params
    params.require(:shipping).permit(:fullname, :address, :email, :phoneNumber, :bank).merge(order_id: params[:order_id])
  end
  
end
