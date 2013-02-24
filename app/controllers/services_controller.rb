class ServicesController < ApplicationController
  layout 'settings'

  def index
    @services = current_user.services
  end

  def create
    @service = current_user.services.build

    if @service.save_with_api(params[:username], params[:password])
      redirect_to services_path
    else
      render :index
    end
  end

  def destroy
    @service = current_user.services.first
    @service.destroy
    redirect_to services_path
  end
end
