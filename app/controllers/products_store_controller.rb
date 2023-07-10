class ProductsStoreController < ApplicationController
   # GET /product_s
   def index
    @products = ProductS.all
    generate_dummy_data if @products.empty?
  end

  # GET /product_s/new
  def new
    @product = ProductS.new
  end

  # POST /product_s
  def create
    @product = ProductS.new(product_params)

    if @product.save
      redirect_to product_s_path, notice: 'Product was successfully created.'
    else
      render :new
    end
  end

  # GET /product_s/:id/edit
  def edit
    @product = ProductS.find(params[:id])
  end

  # PATCH/PUT /product_s/:id
  def update
    @product = ProductS.find(params[:id])

    if @product.update(product_params)
      redirect_to product_s_path, notice: 'Product was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /product_s/:id
  def destroy
    @product = ProductS.find(params[:id])
    @product.destroy
    redirect_to product_s_path, notice: 'Product was successfully destroyed.'
  end

  private

  def product_params
    params.require(:product_s).permit(:name, :description, :price)
  end

  private

  def generate_dummy_data
    if ProductS.count.zero?
      products = [
        { name: 'Cell Phone', description: 'Smartphone with advanced features', image_url: 'https://example.com/cell_phone.jpg', price: rand(300..1000) },
        { name: 'Tablet', description: 'Portable tablet device with a large screen', image_url: 'https://example.com/tablet.jpg', price: rand(200..800) },
        { name: 'Computer', description: 'Desktop or laptop computer for various computing tasks', image_url: 'https://example.com/computer.jpg', price: rand(500..2000) },
        { name: 'Headset', description: 'High-quality audio headset for immersive audio experience', image_url: 'https://example.com/headset.jpg', price: rand(50..300) },
        { name: 'Camera', description: 'Digital camera for capturing stunning photos and videos', image_url: 'https://example.com/camera.jpg', price: rand(200..1000) },
        { name: 'Drone', description: 'Aerial drone for photography and videography', image_url: 'https://example.com/drone.jpg', price: rand(300..1500) },
        { name: 'Smartwatch', description: 'Wearable device with advanced features and health tracking', image_url: 'https://example.com/smartwatch.jpg', price: rand(100..500) },
        { name: 'Gaming Console', description: 'High-performance gaming console for immersive gaming experiences', image_url: 'https://example.com/gaming_console.jpg', price: rand(300..800) },
        { name: 'Wireless Earbuds', description: 'True wireless earbuds for convenient and high-quality audio experience', image_url: 'https://example.com/wireless_earbuds.jpg', price: rand(50..200) },
        { name: 'Virtual Reality Headset', description: 'Immersive virtual reality headset for interactive experiences', image_url: 'https://example.com/vr_headset.jpg', price: rand(200..800) }
  
      ]
  
      products.each do |product|
        ProductS.create(
          name: product[:name],
          description: product[:description],
          image_url: product[:image_url],
          price: product[:price]
        )
      end
    end
  end
  
  
  
end
