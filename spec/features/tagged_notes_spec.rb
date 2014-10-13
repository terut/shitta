require 'rails_helper'

RSpec.describe 'tagged notes' do
  let(:note) { create(:note_with_tags, tags_count: 1) }

  context 'show tagged notes' do
    include_context 'login'

    it 'success' do
      visit tag_path(note.tags[0].name)

      expect(page).to have_content note.title
      expect(page).to have_content note.tags[0].name
    end
  end
end
