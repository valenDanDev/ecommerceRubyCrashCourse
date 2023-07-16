class CategoryController < ApplicationController
   # GET /product_s
   def index
    @categories = Category.all
    generate_dummy_data if @categories.empty?
  end

  # GET /product_s/new
  def new
    @categories = Category.new
  end

  # POST /product_s
  def create
    @categories = Category.new(product_params)

    if @categories.save
      redirect_to product_s_path, notice: 'Product was successfully created.'
    else
      render :new
    end
  end

  # GET /product_s/:id/edit
  def edit
    @categories = Category.find(params[:id])
  end

  # PATCH/PUT /product_s/:id
  def update
    @categories = Category.find(params[:id])

    if @categories.update(product_params)
      redirect_to product_s_path, notice: 'Product was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /product_s/:id
  def destroy
    @categories = Category.find(params[:id])
    @categories.destroy
    redirect_to product_s_path, notice: 'Product was successfully destroyed.'
  end

  private

  def product_params
    params.require(:product_s).permit(:name)
  end

  private

  def generate_dummy_data
    if Category.count.zero?
      products = [
        { name: 'Smartphones'},
        { name: 'Televisions' },
        { name: 'Computers'},
        { name: 'Game Consoles' },
        { name: 'Cameras' },
        { name: "Smart watches"},
        { name: "Speakers"},
        { name: "Drones"},
        { name: "Headphones"}

      ]

      products.each do |categories|
        Category.create(
          name: categories[:name]
        )
      end
    end
  end
end
