class Admin::UsersController < ApplicationController

  before_action :set_user, only: [:edit, :update, :show]
  before_action :require_admin

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to admin_user_path(@user), notice: "ユーザー「#{@user.name}」を登録しました。"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to admin_user_path(@user), notice: "ユーザー「#{@user.name}」を更新しました。"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def show
  end

  def destroy
    user = User.find(params[:id])
    user.destroy
    redirect_to admin_users_path, notice: "ユーザー「#{user.name}」を削除しました。"
  end

  private
  
  def user_params
    params.require(:user).permit(:name, :email, :admin, :password, :password_confirmation)
  end

  def set_user
    @user = User.find(params[:id])
  end

  def require_admin
    redirect_to root_path unless current_user.admin?
  end
end
