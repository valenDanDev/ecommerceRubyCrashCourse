class ShippingController < ApplicationController
  def new
    @shipping = Shipping.new
  end

  def create
    puts"hola probando el metodo"
    puts"hola, se esta ensayando el metodo haber si funciona"
    puts"hola probando el #{shipping_params}"
    @shipping = Shipping.new(shipping_params)

    if @shipping.save
      redirect_to success_shipping_path(order_id: @shipping.order_id)
    else
      puts"error"
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
