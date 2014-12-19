require 'rails_helper'

RSpec.describe 'search_notes' do
  context 'search' do
    include_context 'login'
    before do
      @note1 = create(:note_with_tags, raw_body: "good job\nthank you.")
      @note2 = create(:note_with_tags, raw_body: "good boy\nyou are awesome.")
    end
    it 'success' do
      visit '/'

      fill_in 'q', with: 'job thank'
      find('.input-group-btn button').click

      expect(current_path).to eql search_notes_path
      expect(page).to have_content @note1.title
      expect(page).not_to have_content @note2.title
    end
  end
end
