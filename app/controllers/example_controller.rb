class ExampleController < ApplicationController
  def index
    @products=Example.all
  end
  def show
    @product = Example.find(params[:id])
    end
  def new
    @product = Example.new
    end
     def create
      @product = Example.new(product_params)
      if @product.save
      redirect_to @product
      else
      render :new, status: :unprocessable_entity
      end
      end
      def edit
        @product = Example.find(params[:id])
        end
        def update
        @product = Example.find(params[:id])
        if @product.update(product_params)
        redirect_to @product
        else
        render :edit, status: :unprocessable_entity
        end
        end
        def destroy
          @product = Example.find(params[:id])
          @product.destroy
          redirect_to root_path, status:
          :see_other
          end
      private
      def product_params
      params.require(:product).permit(:name, :description)
      end  
end