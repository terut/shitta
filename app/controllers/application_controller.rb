class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :current_user, :signin?

  before_filter :require_signin

  private

  def current_user
    @current_user ||= User.find_by_id(session[:user_id]) if session[:user_id]
  end

  def signin?
    !!current_user
  end

  def require_signin
    unless signin?
      redirect_to root_path
    end
  end
end
