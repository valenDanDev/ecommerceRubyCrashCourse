class ProductsController  < ApplicationController


  def adminIndex
    @products = Product.all
    @products = Product.paginate(page: params[:page], per_page: 10)
  end
     # GET /products
     def index
      if params[:search].present?
        # Perform a case-insensitive search by product name or description
        @products = Product.where('lower(name) LIKE ? OR lower(description) LIKE ?', "%#{params[:search].downcase}%", "%#{params[:search].downcase}%")
                         .paginate(page: params[:page], per_page: 6)
      elsif params[:category_id].present?
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
        { name: 'Xbox series X', description: 'High-quality audio headset for immersive audio experience', image_url: 'https://img-prod-cms-rt-microsoft-com.akamaized.net/cms/api/am/imageFileData/RE4mRni?ver=8361', price: rand(50..300), categories: ['Game Consoles'] },
        { name: 'Nikon D7500', description: 'Digital camera for capturing stunning photos and videos', image_url: 'https://exitocol.vtexassets.com/arquivos/ids/11723354/camara-nikon-d7500-209-mpx-kit-18-140mm-vr-full-hd-wifi.jpg?v=637794414634100000', price: rand(200..1000), categories: ['Cameras'] },
        { name: 'Xiaomi Redmi 9', description: 'Aerial drone for photography and videography', image_url: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTGRmuf3opsFT1P4HHYXgLnE5bSQzZzlOPiLQ&usqp=CAU', price: rand(300..1500), categories: ['Smart watches'] },
        { name: 'Airpods Max', description: 'Wearable device with advanced features and health tracking', image_url: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRf5hM8xFz13bZZGa3gZtLSPtpghXy70LQnqg&usqp=CAU', price: rand(100..500), categories: ['Headphones'] },
        { name: 'Drone Holy Stone', description: 'It is a compact and versatile quadcopter, designed for easy maneuverability', image_url: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTC_LYVE9eRCx3PBNe3w1Ve6J37O7E_Fz6Xq8N6BNsba8xRTYNEygxtXrhl4BXe5NC8310&usqp=CAU', price: rand(300..800), categories: ['Drones'] },
        { name: 'Smartwatch Samsung Galaxy', description: 'It is offers advanced features and sleek design, making it a cutting-edge wearable device.', image_url: 'https://precio.com.co/wp-content/uploads/relojes-inteligentes/samsung/smartwatch-samsung-galaxy-watch-active-precio-colombia.webp', price: rand(50..200), categories: ['Smart watches'] },
        { name: 'Iphone 14 Pro', description: 'Immersive virtual reality headset for interactive experiences', image_url: 'https://www.losdistribuidores.com/wp-content/uploads/2022/09/iPhone-14-Pro-Purpura.webp', price: rand(200..800), categories: ['Smartphones'] },

        { name: 'Xiaomi Poco X3 Pro', description: 'Smartphone with advanced features', image_url: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQxXi5lSuOutImfpH2noMm9Dw3nKyOpce5xjQqQ7YJ1igM3maIgosGD1YbVTZshknX70hI&usqp=CAU', price: rand(300..900), categories: ['Smartphones'] },
        { name: 'HP FHD 23', description: 'Portable tablet device with a large screen', image_url: 'https://d1pc5hp1w29h96.cloudfront.net/catalog/product/cache/b3b166914d87ce343d4dc5ec5117b502/6/5/65P62AA-1_T1681851108.png', price: rand(200..900), categories: ['Televisions'] },
        { name: 'ASUS Vivobook 14X', description: 'Desktop or laptop computer for various computing tasks', image_url: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSs_RDPiX2vUYP7NGmLyip3eQXZdAPRL9EY6w&usqp=CAU', price: rand(500..2000), categories: ['Computers'] },
        { name: 'Play Station 4', description: 'High-quality audio headset for immersive audio experience', image_url: 'https://tumejoroferta.com/wp-content/uploads/2023/04/D_NQ_NP_798586-MLA40076060236_122019-O.jpg', price: rand(50..400), categories: ['Game Consoles'] },
        { name: 'Pentax KS2', description: 'Digital camera for capturing stunning photos and videos', image_url: 'https://exitocol.vtexassets.com/arquivos/ids/11721986/camara-pentax-k-s2-20mp-dslr-lentes-18-50mm-wr-y-50-200mm-wr.jpg?v=637794402275370000', price: rand(200..1000), categories: ['Cameras'] },
        { name: 'MacBook Pro Apple', description: 'Portable tablet device with a large screen', image_url: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQJUqIhL-vnOU4BAi-6nABaOjAFETVz8PgneagjAajF7WBHRP9iJT5UieIbZAv3F5dfzHk&usqp=CAU', price: rand(300..1500), categories: ['Computers'] },
        { name: 'Sony WH910', description: 'Wearable device with advanced features and health tracking', image_url: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT7aR-QPvJBTIiyn2P1tT_0ecFtoTttf_Q4pcx77zIMOlzzOOmngkvRHZ6K8x7SACugeO0&usqp=CAU', price: rand(100..500), categories: ['Headphones'] },
        { name: 'Drone DJI Mavic', description: 'It is a compact and versatile quadcopter, designed for easy maneuverability', image_url: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSmNaAPqcFhVS-NIbolDZ3f8IKFd3-cx_7Z3g&usqp=CAU', price: rand(300..850), categories: ['Drones'] },
        { name: 'Smartwatch Xiaomi Band 5', description: 'It is offers advanced features and sleek design, making it a cutting-edge wearable device.', image_url: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRH2k53hb9nmNpxooZumH6MSIE5PG_DBh6yJZpZKBIBzo2GMl3y4NH2e3mmzc4ZAqiIgtI&usqp=CAU', price: rand(50..200), categories: ['Headphones'] },
        { name: 'Samsung Galaxy S10', description: 'Immersive virtual reality headset for interactive experiences', image_url: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRG4QqDNEoyuWzD9hiZKYdGpkadQKpjCuV7Cw&usqp=CAU', price: rand(200..1200), categories: ['Smartphones'] }
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
