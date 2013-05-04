class CommentsController < ApplicationController
  def create
    @note = Note.find(params[:note_id])
    @comment = current_user.comments.build(params[:comment])
    @comment.note = @note
    @comment.save
    redirect_to note_path(@note)
  end

  def edit

  end

  def destroy

  end
end
