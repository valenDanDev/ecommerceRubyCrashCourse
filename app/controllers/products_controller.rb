class ProductsController  < ApplicationController
   # GET /product_s
   def index
    @products = Product.all
    generate_dummy_data if @products.empty?
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
        { name: 'Cell Phone', description: 'Smartphone with advanced features', image_url: 'https://example.com/cell_phone.jpg', price: rand(300..1000), categories: ['communication','multimedia'] },
        { name: 'Tablet', description: 'Portable tablet device with a large screen', image_url: 'https://example.com/tablet.jpg', price: rand(200..800), categories: ['multimedia'] },
        { name: 'Computer', description: 'Desktop or laptop computer for various computing tasks', image_url: 'https://example.com/computer.jpg', price: rand(500..2000), categories: ['productivity'] },
        { name: 'Headset', description: 'High-quality audio headset for immersive audio experience', image_url: 'https://example.com/headset.jpg', price: rand(50..300), categories: ['audio'] },
        { name: 'Camera', description: 'Digital camera for capturing stunning photos and videos', image_url: 'https://example.com/camera.jpg', price: rand(200..1000), categories: ['multimedia'] },
        { name: 'Drone', description: 'Aerial drone for photography and videography', image_url: 'https://example.com/drone.jpg', price: rand(300..1500), categories: ['remote control'] },
        { name: 'Smartwatch', description: 'Wearable device with advanced features and health tracking', image_url: 'https://example.com/smartwatch.jpg', price: rand(100..500), categories: ['multimedia'] },
        { name: 'Gaming Console', description: 'High-performance gaming console for immersive gaming experiences', image_url: 'https://example.com/gaming_console.jpg', price: rand(300..800), categories: ['gaming','multimedia'] },
        { name: 'Wireless Earbuds', description: 'True wireless earbuds for convenient and high-quality audio experience', image_url: 'https://example.com/wireless_earbuds.jpg', price: rand(50..200), categories: ['audio'] },
        { name: 'Virtual Reality Headset', description: 'Immersive virtual reality headset for interactive experiences', image_url: 'https://example.com/vr_headset.jpg', price: rand(200..800), categories: ['XR','multimedia'] }
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

    # def indexCategory
    #   category = params[:category]
    #   # Utiliza el nombre de la categoría para filtrar los productos correspondientes
    #   @products = Product.where(category: category)
    # end
  end
end
