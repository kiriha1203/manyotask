class UsersController < ApplicationController
  skip_before_action :login_required, only: [:new, :create]
  before_action :set_user, only: [:edit, :show, :update]

  def new
    login_reject_sign_in
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to tasks_url, success: "ユーザー「#{@user.name}」を登録しました。"
    else
      render :new
    end
  end

  def edit
  end

  def update
    if params[:user][:password].blank?
      params[:user].delete("password")
    end
    if @user.update(user_params)
      redirect_to user_url(@user), success: "ユーザー「#{@user.name}」を更新しました。"
    else
      render :edit
    end
  end

  def show
    redirect_to tasks_path unless @user.id == current_user.id
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :admin, :password, :password_confirmation)
  end

  def set_user
    @user = User.find(params[:id])
  end

  def login_reject_sign_in
    redirect_to tasks_url, danger: "ログイン中は登録を行えません。" if current_user
  end
end
