class ProductsController  < ApplicationController
   # GET /product_s
   def index
    if params[:category_id].present?
      category = Category.find(params[:category_id])
      @products = category.product
    else
      @products = Product.all
      generate_dummy_data if @products.empty?
    end
  
    @products ||= [] # Set @products to an empty array if it's nil
  
    respond_to do |format|
      format.html
      format.js
    end
  end
  

  def show
    @product = Product.find(params[:id])
  end


  # GET /product_s/new
  def new
    @product = Product.new
  end

  # POST /product_s
  def create
    @product = Product.new(product_params)

    if @product.save
      redirect_to product_s_path, notice: 'Product was successfully created.'
    else
      render :new
    end
  end

  # GET /product_s/:id/edit
  def edit
    @product = Product.find(params[:id])
  end

  # PATCH/PUT /product_s/:id
  def update
    @product = Product.find(params[:id])

    if @product.update(product_params)
      redirect_to product_s_path, notice: 'Product was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /product_s/:id
  def destroy
    @product = Product.find(params[:id])
    @product.destroy
    redirect_to product_s_path, notice: 'Product was successfully destroyed.'
  end

  private

  def product_params
    params.require(:product_s).permit(:name, :description, :price)
  end

  private

  def generate_dummy_data
    if Product.count.zero?
      products = [
        { name: 'Cell Phone Samsung', description: 'Smartphone with advanced features', image_url: 'https://example.com/cell_phone.jpg', price: rand(300..1000), categories: ['Smartphones'] },
        { name: 'Tv LG', description: 'Portable tablet device with a large screen', image_url: 'https://example.com/tablet.jpg', price: rand(200..800), categories: ['Televisions'] },
        { name: 'Computer Lenovo', description: 'Desktop or laptop computer for various computing tasks', image_url: 'https://example.com/computer.jpg', price: rand(500..2000), categories: ['Computers'] },
        { name: 'Xbox series X', description: 'High-quality audio headset for immersive audio experience', image_url: 'https://example.com/headset.jpg', price: rand(50..300), categories: ['Game Consoles'] },
        { name: 'Camera 48 mpx', description: 'Digital camera for capturing stunning photos and videos', image_url: 'https://example.com/camera.jpg', price: rand(200..1000), categories: ['Cameras'] },
        { name: 'smart watch apple', description: 'Aerial drone for photography and videography', image_url: 'https://example.com/drone.jpg', price: rand(300..1500), categories: ['Smart watches'] },
        { name: 'Speaker JBL', description: 'Wearable device with advanced features and health tracking', image_url: 'https://example.com/smartwatch.jpg', price: rand(100..500), categories: ['Speakers'] },
        { name: 'Super Drone', description: 'High-performance gaming console for immersive gaming experiences', image_url: 'https://example.com/gaming_console.jpg', price: rand(300..800), categories: ['Drones'] },
        { name: 'Wireless Earbuds', description: 'True wireless earbuds for convenient and high-quality audio experience', image_url: 'https://example.com/wireless_earbuds.jpg', price: rand(50..200), categories: ['Headphones'] },
        { name: 'Cell Phone Samsung Promax14', description: 'Immersive virtual reality headset for interactive experiences', image_url: 'https://example.com/vr_headset.jpg', price: rand(200..800), categories: ['Smartphones'] }
      ]

      products.each do |product_data|
        categories = product_data[:categories].map do |category_name|
          Category.find_or_create_by(name: category_name)
        end

        product = Product.create(
          name: product_data[:name],
          description: product_data[:description],
          image_url: product_data[:image_url],
          price: product_data[:price]
        )
        puts "Product ID: #{product.id}"

        categories.each do |category|
          product_category = ProductCategory.new(product_id: product.id, category_id: category.id)
          if product_category.save
            puts "ProductCategory created successfully"
          else
            puts "ProductCategory creation failed"
            puts product_category.errors.full_messages
          end
        end
      end
    end
  end
end
