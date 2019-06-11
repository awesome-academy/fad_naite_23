class Admin::ProductsController < ApplicationController
  before_action :load_product, only: :destroy

  def index
    @products = Product.newest.paginate page: params[:page],
      per_page: Settings.index_per_page
  end

  def new
    @product = Product.new
    @categories = Category.all
  end

  def create
    @product = Product.new product_params
    if @product.save
      flash[:success] = t "product_created"
      redirect_to new_admin_product_path
    else
      flash.now[:danger] = t "create_failed"
      render :new
    end
  end

  def destroy
    flash[:success] = @product.destroy ? t("product_delete") : t("delete_failed")
    redirect_to admin_products_path
  end

  private

  def product_params
    params.require(:product).permit :name, :description, :product_type,
      :category_id, :price, :discount, :picture
  end
end
