class ProductsController  < ApplicationController


  def adminIndex
    @products = Product.all
  end
     # GET /products
  def index
    if params[:category_id].present?
      category = Category.find(params[:category_id])
      @products = category.products.paginate(page: params[:page], per_page: 6)
    else
      @products = Product.paginate(page: params[:page], per_page: 6)
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

  # GET /products/new
  def new
    @product = Product.new
  end

  # POST /products
  def create
    @product = Product.new(product_params) 
    @category_id = params[:product][:category_id]
    puts "hola #{@category_id}"
    if @product.save
      product_category = ProductCategory.new(product_id: @product.id, category_id:@category_id)
      if product_category.save
        redirect_to admin_path, notice: 'Product was successfully created.'
      else
        # Display errors for product_category
        puts product_category.errors.full_messages
        render :new
      end
    else
      puts @product.errors.full_messages
      render :new
    end
  end

  # GET /products/:id/edit
  def edit
    @product = Product.find(params[:id])
  end

  def delete_confirmation
    @product = Product.find(params[:id])
    @product_name = @product.name
    @product_description = @product.description
  end

  def deleteFailed
    @product = Product.find(params[:id])
    @product_name = @product.name
    @product_description = @product.description
  end

  # PATCH/PUT /products/:id
  def update
    @product = Product.find(params[:id])

    if @product.update(product_params)
      redirect_to admin_path, notice: 'Product was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /products/:id
  def destroy
    def destroy
      @product =  Product.find(params[:id])
      @orderItem = OrderItem.find_by(product_id: @product.id)
    
      # Check if the @orderItem is associated with the product
      if @orderItem
        puts "it can not be deleted"
        redirect_to errorDeleting_admin_path, alert: 'Cannot delete product. It has associated OrderItems.'
      else
        product_category = ProductCategory.find_by(product_id: @product.id)
        product_category.destroy if product_category
    
        @product.destroy
        redirect_to admin_path, notice: 'Product was successfully destroyed.'
      end
    end
    
  end
  


  private

  def product_params
    params.require(:product).permit(:name, :description, :price,:image_url)
  end
  



  private

  def generate_dummy_data
    if Product.count.zero?
      products = [
        { name: 'Samsung S23 Ultra', description: 'Smartphone with advanced features', image_url: 'https://gsmphone.co/wp-content/uploads/2023/02/SamsungGalaxyS23Ultra-3_900x.webp', price: rand(300..1000), categories: ['Smartphones'] },
        { name: 'TV LG AI ThinQ', description: 'Portable tablet device with a large screen', image_url: 'https://www.lg.com/co/images/televisores/md07527587/gallery/dm-01.jpg', price: rand(200..800), categories: ['Televisions'] },
        { name: 'Lenovo Legion 5', description: 'Desktop or laptop computer for various computing tasks', image_url: 'https://www.lenovo.com/medias/lenovo-laptop-legion-5-15-intel-series-gallery-1.png?context=bWFzdGVyfHJvb3R8NDA0NDIwfGltYWdlL3BuZ3xoNWYvaDYwLzE0MzMyNjk1NjA5Mzc0LnBuZ3xiNmJkZjljMzk0MDU0NTEzYTExZDdmYjc2MjhiMThiMDlkOGFmMjZjZjdhZGJmYTNlMWQ4NjQ3OGQ2Njk3MzBh', price: rand(500..2000), categories: ['Computers'] },
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