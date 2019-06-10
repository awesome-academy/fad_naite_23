class CartsController < ApplicationController
  before_action :calc_total, except: :destroy

  def show; end

  def remove_item
    @cart.delete cart_params[:id] if @cart.key? cart_params[:id]
    redirect_to cart_path
  end

  def update_item
    @cart[cart_params[:id]] = cart_params[:quantity].to_i
    redirect_to cart_path
  end

  private

  def cart_params
    # Need sanitize id and quantity to integer for better handling
    params.require(:cart).permit :id, :quantity
  end

  def calc_total
    return if @cart.empty?
    @products = Product.newest.in_cart(@cart.keys)
    @cart_total = @products.reduce(@cart_total) do |sum, product|
      discount = product.discount ? product.discount : 1
      sum + product.price * discount * @cart[product.id.to_s]
    end
  end
end
