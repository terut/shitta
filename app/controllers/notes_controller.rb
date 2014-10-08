class NotesController < ApplicationController
  def index
    @notes = Note.latest.page(params[:page])
  end

  def show
    @note = Note.find(params[:id])
  end

  def new
    @note = Note.new
  end

  def create
    @note = current_user.notes.build(note_params)

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

    if @note.update_attributes(note_params)
      redirect_to note_path(@note)
    else
      render :new
    end
  end

  def share
    # TODO decorator
    @note = current_user.notes.find(params[:id])
    @note.share(current_user)
    redirect_to note_path(@note)
  end

  private

  def note_params
    params.require(:note).permit(:raw_body, :title, :tag_list)
  end
end
