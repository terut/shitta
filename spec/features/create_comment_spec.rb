require 'rails_helper'

RSpec.describe 'edit_note' do
  context 'edit with own note' do
    include_context 'login'
    before do
      allow_any_instance_of(Comment).to receive(:comment_notify)
      @own_note = create(:note, user:current_user)
    end
    it 'success' do
      visit '/'

      click_link "#{@own_note.title}"

      expect(current_path).to eql note_path(@own_note)

      expect(page).to have_content 'Comment'

      fill_in 'comment_raw_body', with: "# capybara comment raw body"

      click_button 'Post'

      expect(page).to have_content 'capybara comment raw body'
    end
  end
end
