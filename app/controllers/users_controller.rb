class UsersController < ApplicationController
  before_action :require_log_in, :load_user, only: %i(show edit update)
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

  def edit; end

  def update
    if @user.update_attributes user_params
      flash[:success] = t "update_successful"
      redirect_to @user
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :phone_number, :address,
      :password, :password_confirmation)
  end
end
