class SessionsController < ApplicationController
  def new
  end

  def create
    if params[:username].blank? || params[:password].blank?
      flash.now[:alert] = '※ユーザー名とパスワードを入力してください'
      render :new, status: :unprocessable_entity
      return
    end

    user = User.find_by(username: params[:username])
    if user&.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to root_path, notice: 'ログインしました'
    else
      flash.now[:alert] = 'ユーザー名またはパスワードが正しくありません'
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to login_path, notice: 'ログアウトしました'
  end
end
 