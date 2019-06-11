class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper

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
end
