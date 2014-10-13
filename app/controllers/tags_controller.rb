class TagsController < ApplicationController
  def autocomplete
    @tags = Tag.where("name like ?", "#{params[:q]}%").limit(10).pluck(:name)
    render json: @tags
  end

  def show
    @tags = Tag.all
    @tag = Tag.find_by_name(params[:id])
    @notes = @tag.notes.with_tags.with_author.latest.page(params[:page])
    render layout: 'notes'
  end
end
