class ApplicationController < ActionController::Base
    before_action :set_render_cart
    before_action :initialize_cart

    def set_render_cart
        @render_cart=true
    end 

    def initialize_cart
        @cart ||=Cart.find_by(id: session[:cart_id])
        
        if @cart.nil?
            @cart=Cart.create
            session[:cart_id]=@cart.id
        end     
    end     

    helper_method :current_cart

    def current_cart
      # Logic to retrieve the current cart based on the session or any other criteria
      # For example:
      if session[:cart_id]
        Cart.find_by(id: session[:cart_id])
      else
        cart = Cart.create
        session[:cart_id] = cart.id
        cart
      end
    end
end
