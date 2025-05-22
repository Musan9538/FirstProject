class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_user, :logged_in?, :require_user, :require_admin

  private

  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  def logged_in?
    !!current_user
  end

  def require_user
    unless logged_in?
      flash[:alert] = "ログインが必要です"
      redirect_to login_path
    end
  end

  def require_admin
    unless logged_in? && current_user.is_admin?
      flash[:alert] = "管理者権限が必要です"
      redirect_to root_path
    end
  end
end
