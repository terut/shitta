class NotesController < ApplicationController
  def index
    @notes = Note.all
  end

  def show
    @note = Note.find(params[:id])
  end

  def new
    @note = Note.new
  end

  def create
    @note = current_user.notes.build(params[:note])

    if @note.save
      redirect_to root_path
    else
      render :new
    end
  end
end
