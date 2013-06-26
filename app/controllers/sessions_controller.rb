class SessionsController < ApplicationController
  skip_before_filter :require_signin, only: [:welcome, :new, :create]

  def create
    user = User.find_by_username(params[:username])

    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to root_path
    else
      flash.now.alert = 'Invalid username or password'
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    reset_session
    redirect_to root_path
  end
end
