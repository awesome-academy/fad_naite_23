class UsersController < ApplicationController
  before_action :require_log_in, :load_user, only: :show
  def show; end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      log_in @user
      redirect_to @user
    else
      render :new
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :phone_number, :address,
      :password, :password_confirmation)
  end

  def load_user
    return if @user = User.find_by(id: params[:id])
    flash[:danger] = t "controller.user_not_found"
    redirect_to root_url
  end
end
