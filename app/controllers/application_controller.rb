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
end
