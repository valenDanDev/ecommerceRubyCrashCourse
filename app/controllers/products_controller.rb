class ProductsController  < ApplicationController


  def adminIndex
    if params[:search].present?
      @products = Product.where("name LIKE ? OR description LIKE ?", "%#{params[:search]}%", "%#{params[:search]}%").paginate(page: params[:page], per_page: 10)
    else
      @products = Product.paginate(page: params[:page], per_page: 10)
    end
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
        { name: 'Xiaomi Redmi 9', description: 'Aerial drone for photography and videography', image_url: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTGRmuf3opsFT1P4HHYXgLnE5bSQzZzlOPiLQ&usqp=CAU', price: rand(300..1500), categories: ['Smartphones'] },
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
        { name: 'Samsung Galaxy S10', description: 'Immersive virtual reality headset for interactive experiences', image_url: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRG4QqDNEoyuWzD9hiZKYdGpkadQKpjCuV7Cw&usqp=CAU', price: rand(200..1200), categories: ['Smartphones'] },

        { name: 'Motorola Edge 40', description: 'Smartphone with advanced features', image_url: 'https://i.blogs.es/45176e/motorola-edge-40-1/450_1000.jpeg', price: rand(300..900), categories: ['Smartphones'] },
        { name: 'Hisense 50 Inch TV ', description: 'Portable tablet device with a large screen', image_url: 'https://fullhogar.com.co/wp-content/uploads/2023/06/50A6HV-2.jpg', price: rand(200..900), categories: ['Televisions'] },
        { name: 'Lenovo ThinkPad E15', description: 'Desktop or laptop computer for various computing tasks', image_url: 'https://www.lenovo.com/medias/22tpe15e5n2.png?context=bWFzdGVyfHJvb3R8NDU3OTQwfGltYWdlL3BuZ3xoMGYvaDI3LzE0MzE1NTQwODQwNDc4LnBuZ3wzYjlkMWM3NWU5N2E1ZTc1MmMyYjM0NjY3MDJmZDQ5NmNmZDcyNzc3ZDhlZTcxODM5NWI1NTdlNDA4NDAxMGY2', price: rand(500..2000), categories: ['Computers'] },
        { name: 'Play Station 5', description: 'High-quality audio headset for immersive audio experience', image_url: 'https://cosonyb2c.vtexassets.com/arquivos/ids/355910/711719556220_001.jpg?v=638041127393770000', price: rand(50..400), categories: ['Game Consoles'] },
        { name: 'Go Pro Hero 10', description: 'Digital camera for capturing stunning photos and videos', image_url: 'https://thehousetechnology.com/567-large_default/camara-gopro-10-black.jpg', price: rand(200..1000), categories: ['Cameras'] },
        { name: 'Asus Vivo Book', description: 'Portable tablet device with a large screen', image_url: 'https://falabella.scene7.com/is/image/FalabellaCO/3931720_1?wid=800&hei=800&qlt=70', price: rand(300..1500), categories: ['Computers'] },
        { name: 'JBL 650 BTNC', description: 'Wearable device with advanced features and health tracking', image_url: 'https://www.jbl.com.gt/dw/image/v2/AAUJ_PRD/on/demandware.static/-/Sites-masterCatalog_Harman/default/dw39ab3278/JBL_LIVE650BTNC_Product-Image_Hero_Blue_067_x1-1605x1605px.png?sw=537&sfrm=png', price: rand(100..500), categories: ['Headphones'] },
        { name: 'Phanton CJ', description: 'It is a compact and versatile quadcopter, designed for easy maneuverability', image_url: 'https://s.wsj.net/public/resources/images/MK-CQ670_CHINAD_M_20141110171209.jpg', price: rand(300..850), categories: ['Drones'] },
        { name: 'Huawei Watch Fit', description: 'It is offers advanced features and sleek design, making it a cutting-edge wearable device.', image_url: 'https://consumer.huawei.com/content/dam/huawei-cbg-site/common/mkt/list-image/wearables/watch-fit/watch-fit-listimage-Graphite-Black.png', price: rand(50..200), categories: ['Headphones'] },
        { name: 'Samsung Galaxy A54 5G', description: 'Immersive virtual reality headset for interactive experiences', image_url: 'https://images.samsung.com/is/image/samsung/p6pim/co/sm-a546elvdltc/gallery/co-galaxy-a54-5g-sm-a546-454286-sm-a546elvdltc-536375631?$650_519_PNG$', price: rand(200..1200), categories: ['Smartphones'] },
        { name: 'OPPO A57 128GB', description: 'It is offers advanced features and sleek design, making it a cutting-edge wearable device.', image_url: 'https://gsmphone.co/wp-content/uploads/2023/01/59149344_1.jpeg', price: rand(50..200), categories: ['Smartphones'] },
        { name: 'Tecno Spark 10 PRO', description: 'Immersive virtual reality headset for interactive experiences', image_url: 'https://www.alcarrito.com/media/catalog/product/d/i/diapositiva2_2_1.png?width=600&height=600&canvas=600,600&optimize=medium&bg-color=255,255,255&fit=bounds&format=jpeg', price: rand(200..1200), categories: ['Smartphones'] }
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
