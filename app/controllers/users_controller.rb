class UsersController < ApplicationController
  skip_before_filter :require_signin, only: [:new, :create]

  layout 'application', only: [:new, :create]

  helper_method :user

  def show
    @notes = user.notes
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user].reverse_merge(name: params[:user][:username]))

    if @user.save
      session[:user_id] = @user.id
      redirect_to root_path
    else
      render :new
    end
  end

  private

  def user
    @user ||= User.find_by_username!(params[:id])
  end
end
