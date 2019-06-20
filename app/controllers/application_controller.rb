class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper

  before_action :set_cart

  private

  def require_log_in
    return if logged_in?
    store_location
    flash[:danger] = t "require_login"
    redirect_to login_url
  end

  def admin_user
    redirect_to(root_url) unless current_user.admin?
  end

  def load_user
    return if @user = User.find_by(id: params[:id])
    flash[:danger] = t "controller.user_not_found"
    redirect_to root_url
  end

  def load_product
    return if @product = Product.find_by(id: params[:id])
    flash[:danger] = t "controller.product_not_found"
    redirect_to root_url
  end

  def set_cart
    session[:cart] ||= {}
    session[:cart_total] ||= 0
    @cart = session[:cart]
    @cart_total = session[:cart_total]
  end

  def calc_sub_total
    @sub_total = @order.order_lists.reduce(0) do |sum, item|
      sum + item.unit_sold_price * item.quantity
    end
  end

  def query_search_products
    @products = Product.newest.by_type(params[:search]).paginate(
      page: params[:page],
      per_page: Settings.index_per_page
    )
  end
end
