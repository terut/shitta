class NotesController < ApplicationController
  def index
    @notes = Note.with_tags.with_author.latest.page(params[:page])
    @tags = Tag.all
  end

  def show
    @note = Note.with_tags.with_author.with_favorited_users.find(params[:id])
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
    @note = find_note
    render :new
  end

  def update
    @note = find_note

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

  def find_note
    if current_user.admin?
      return Note.find(params[:id])
    end
    current_user.notes.find(params[:id])
  end
end
