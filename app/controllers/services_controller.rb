class ServicesController < ApplicationController
  layout 'settings'

  def index
    @services = current_user.services
  end

  def create
    @service = current_user.services.build

    if @service.save_with_api(params[:username], params[:password])
      redirect_to root_path
    else
      render :new
    end
  end
end
