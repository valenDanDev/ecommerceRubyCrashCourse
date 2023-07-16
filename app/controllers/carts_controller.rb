class CartsController < ApplicationController
    # GET /carts
    def show
        @cart = Cart.find(params[:id])
        @product = Product.find(params[:product_id])
      end
  
    # POST /carts
    def create
      @cart = Cart.new
      @cart.user = current_user # Assuming you have authentication and current_user method
      
      if @cart.save
        redirect_to @cart, notice: 'Cart was successfully created.'
      else
        render :new
      end
    end
  
    # PATCH/PUT /carts/:id
    def update
      @cart = Cart.find(params[:id])
      
      if @cart.update(cart_params)
        redirect_to @cart, notice: 'Cart was successfully updated.'
      else
        render :edit
      end
    end
  
    # DELETE /carts/:id
    def destroy
      @cart = Cart.find(params[:id])
      @cart.destroy
      
      redirect_to root_path, notice: 'Cart was successfully destroyed.'
    end
  
    # POST /carts/:id/add_item/:product_id
    def add_item
      puts "Hello, the add_item action was called!"
      @product = Product.find(params[:product_id])
      puts "Product Name: #{@product.name}"
      puts "Product Price: #{@product.price}"
      
      ##@cart.total_items = 1
      ##@cart.total_price = @product.price
      @cart = Cart.find_or_create_by(total_items: 1, total_price: @product.price)
     
      @product = Product.find(params[:product_id])
      @cart_item = @cart.cart_items.find_or_initialize_by(product_id: @product.id,subtotal: @product.price)
      @cart_item.quantity ||= 0
      @cart_item.quantity += 1
      
      if @cart_item.save
        flash[:notice] = 'Item was successfully added to the cart.'
      else
        render :show
      end
    end
    
      
  
    private
  
    def cart_params
      params.require(:cart).permit(:total_items, :total_price)
    end
  end
  