# TODO accountsController
class UsersController < ApplicationController
  skip_before_filter :require_signin, only: [:new, :create]
  before_filter :require_own, only: [:edit, :update]

  layout 'settings', only: [:edit, :update]

  helper_method :user

  def show
    @notes = user.notes.latest.page(params[:page])
  end

  # TODO refactor layout
  def new
    @user = User.new
    render layout: 'application'
  end

  def create
    params[:user].reverse_merge!(name: params[:user][:username])
    @user = User.new(registration_params)

    if @user.save
      session[:user_id] = @user.id
      redirect_to root_path
    else
      # TODO rails 4.0 remove password_digest validation
      @user.errors.messages.delete(:password_digest)
      render :new, layout: 'application'
    end
  end

  def update
    if user.update_attributes(user_params)
      redirect_to profile_path
    else
      render :edit
    end
  end

  private

  def user
    params[:id] ||= current_user.username
    @user ||= User.find_by_username!(params[:id])
  end

  def current_user?
    current_user.id == user.id
  end

  def require_own
    unless current_user?
      redirect_to root_path
    end
  end

  def user_params
    params.require(:user).permit(:name, :email, :bio, :avatar, :avatar_cache)
  end

  def registration_params
    params.require(:user).permit(:username, :name, :email, :bio, :password, :password_confirmation)
  end
end
