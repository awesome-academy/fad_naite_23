class Admin::UsersController < AdminController
  before_action :load_user, only: :destroy

  def index
    @users = User.name_alphabet.paginate page: params[:page],
      per_page: Settings.index_per_page
  end

  def destroy
    flash[:success] = @user.destroy ? t("user_deleted") : t("delete_failed")
    redirect_to admin_users_path
  end
end
