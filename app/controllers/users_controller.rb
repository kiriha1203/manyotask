class UsersController < ApplicationController
  skip_before_action :login_required, only: [:new, :create]

  def new
    login_reject_sign_in
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to tasks_url, notice: "ユーザー「#{@user.name}」を登録しました。"
    else
      render :new
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])

    if @user.update(user_params)
      redirect_to user_url(@user), notice: "ユーザー「#{@user.name}」を更新しました。"
    else
      render :edit
    end
  end

  def show
    if params[:id] == current_user.id
      @user = User.find(params[:id])
    else
      redirect_to tasks_path
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :admin, :password, :password_confirmation)
  end

  def login_reject_sign_in
    redirect_to tasks_url, notice: "ログイン中は登録を行えません。" if current_user
  end
end
