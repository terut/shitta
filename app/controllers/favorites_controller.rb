class FavoritesController < ApplicationController
  respond_to :json

  # TODO refactoring N+1 problem and rspec
  def create
    note = Note.active.find(params[:note_id])
    fav = current_user.favorites.find_by_note_id(note)
    params[:point] = 1 unless params[:point].to_i > 0
    if fav
      Favorite.update_counters(fav.id, point: params[:point].to_i)
    else
      current_user.favorites.create(note: note, point: params[:point].to_i)
    end
    head :no_content
  end

  def destroy
    note = Note.active.find(params[:note_id])
    fav = current_user.favorites.find_by_note_id(note)
    fav.destroy
    head :no_content
  end
end
