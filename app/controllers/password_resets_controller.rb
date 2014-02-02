class PasswordResetsController < ApplicationController
  skip_before_filter :require_signin

  def create
    user = User.find_by_email(params[:email])
    if user && user.save_reset_token
      flash.notice = 'Send email'
      Message.forgot_password(user).deliver
      redirect_to new_password_reset_path
    else
      flash.now.alert = 'Invalid email'
      render :new
    end
  end

  def edit
    @user = User.with_reset_token(params[:id]).first
    unless @user
      flash.alert = 'Invalid URL'
      redirect_to new_password_reset_path
    end
  end

  def update
    @user = User.with_reset_token(params[:id]).first
    if @user && @user.reset_password(params[:password], params[:password_confirmation])
      flash.notice = 'Reset password'
      redirect_to signin_path
    else
      flash.now.alert = 'Invalid password'
      render :edit
    end
  end
end
