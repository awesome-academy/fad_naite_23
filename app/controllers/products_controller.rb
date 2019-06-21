class ProductsController < ApplicationController
  before_action :load_product, :calc_avg_rating, only: :show
  before_action :load_related_categories, only: :index

  def index
    if search_params.empty?
      @products = Product.newest.paginate page: params[:page],
        per_page: Settings.index_per_page
    else
      query_search_products
    end
  end

  def show; end

  private

  def search_params
    params.permit :by_type, :top_rating, :category, :price
  end

  def query_search_products
    search_params.each do |key, value|
      next unless value.present?
      @products = Product.public_send(key, value).paginate(
        page: params[:page],
        per_page: Settings.index_per_page
      )
    end
  end

  def load_related_categories
    # Just testing filtering view
    @categories = Category.newest.take(Settings.slider_number)
  end
end
