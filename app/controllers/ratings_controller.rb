class RatingsController < ApplicationController
  before_action :load_rated_product, only: :create

  def create
    rating = current_user.ratings.new rating_params
    @flag = rating.save
    respond_to do |format|
      format.html{redirect_to @product}
      format.js
    end
  end

  private

  def rating_params
    params.require(:rating).permit :product_id, :rate
  end

  def load_rated_product
    return if @product = Product.find_by(id: rating_params[:product_id])
    flash[:danger] = t "product_not_found"
    redirect_to products_path
  end
end
