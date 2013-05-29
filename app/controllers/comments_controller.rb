class CommentsController < ApplicationController
  def create
    @note = Note.find(params[:note_id])
    @comment = current_user.comments.build(params[:comment])
    @comment.note = @note
    @comment.save
    redirect_to note_path(@note)
  end

  def edit
    @comment = current_user.comments.find(params[:id])
  end

  def update
    @comment = current_user.comments.find(params[:id])
    if @comment.update_attributes(params[:comment])
      redirect_to note_path(@comment.note_id)
    else
      render :edit
    end
  end

  def destroy

  end
end
