class ProductsController < ApplicationController
  before_action :load_product, only: :show

  def index
    query_search_products
  end

  def show; end
end
