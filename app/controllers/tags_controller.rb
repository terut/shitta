class TagsController < ApplicationController
  def autocomplete
    @tags = Tag.where("name like ?", "#{params[:q]}%").limit(10).pluck(:name)
    render json: @tags
  end
end
