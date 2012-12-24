class UsersController < ApplicationController
  skip_before_filter :require_signin, only: [:new, :create]

  layout 'application', only: [:new, :create]

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
end
