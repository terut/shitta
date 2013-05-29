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
      redirect_to note_path(@note)
    else
      render :new
    end
  end

  def edit
    @note = current_user.notes.find(params[:id])
    render :new
  end

  def update
    @note = current_user.notes.find(params[:id])

    if @note.update_attributes(params[:note])
      redirect_to note_path(@note)
    else
      render :edit
    end
  end

  def share
    # TODO decorator
    @note = current_user.notes.find(params[:id])
    @note.share(current_user)
    redirect_to note_path(@note)
  end
end
