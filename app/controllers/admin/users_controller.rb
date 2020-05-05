class Admin::UsersController < ApplicationController
  before_action :require_admin
  before_action :set_user, only: [:edit, :show, :update, :destroy]
  skip_before_action :login_required, only: [:new, :create]

  def index
    @users = User.includes(:tasks)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to admin_users_path, success: "ユーザー「#{@user.name}」を登録しました。"
    else
      render :new
    end
  end

  def edit
  end

  def update
    # editのパスワード無記入時元のまま登録させる（バリデーションエラーを発生させない）
    params[:user].delete("password") if params[:user][:password].blank?
    if @user.update(user_params)
      redirect_to admin_user_url(@user), success: "ユーザー「#{@user.name}」を更新しました。"
    else
      render :edit
    end
  end

  def show
    @user_tasks = @user.tasks.page(params[:page]).per(10)
  end

  def destroy
    if @user.destroy
      redirect_to admin_users_path, success: "ユーザー「#{@user.name}」を削除しました。"
    else
      redirect_to admin_users_path, danger: "削除できませんでした。管理者は最低一人必要です。"
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :admin, :password, :password_confirmation)
  end

  def require_admin
    redirect_to tasks_url, warning: "管理者権限がありません。" unless current_user.admin?
  end

  def set_user
    @user = User.find(params[:id])
  end
end
