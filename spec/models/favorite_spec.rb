require 'spec_helper'

describe Favorite do
  describe "unique index note and user" do
    before do
      @fav = create(:favorite)
    end

    it 'raise RecordNotUnique error' do
      expect {
        Favorite.create(note_id: @fav.note_id, user_id: @fav.user_id, point: 1)
      }.to raise_error(ActiveRecord::RecordNotUnique)
    end
  end
end
