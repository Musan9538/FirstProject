class UsersController < ApplicationController
  before_action :require_admin
  before_action :set_user, only: [:edit, :update, :destroy]
  
  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:notice] = "ユーザーを作成しました"
      redirect_to users_path
    else
      flash.now[:alert] = "ユーザーの作成に失敗しました"
      render :new, status: :unprocessable_entity
    end
  end
  
  def update
    if params[:user][:password].blank? && params[:user][:password_confirmation].blank?
      params[:user].delete(:password)
      params[:user].delete(:password_confirmation)
    end

    if @user.update(user_params)
      flash[:notice] = "ユーザー情報を更新しました"
      redirect_to users_path
    else
      flash.now[:alert] = "ユーザー情報の更新に失敗しました"
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @user == current_user
      flash[:alert] = "自分のアカウントを削除することはできません"
      redirect_to users_path and return
    end

    if @user.destroy
      flash[:notice] = "ユーザーを削除しました"
    else
      flash[:alert] = "ユーザーの削除に失敗しました"
    end
    redirect_to users_path
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:username, :password, :password_confirmation, :is_admin)
  end
end
