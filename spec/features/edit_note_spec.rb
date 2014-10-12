require 'rails_helper'

RSpec.describe 'edit_note' do
  context 'edit with own note' do
    include_context 'login'
    before do
      @own_note = create(:note, user:current_user)
    end
    it 'success' do
      visit '/'

      click_link "#{@own_note.title}"

      expect(current_path).to eql note_path(@own_note)

      expect(page).to have_content 'Edit'
      expect(page).to have_content 'Connect Qiita'

      click_link 'Edit'

      expect(current_path).to eql edit_note_path(@own_note)

      fill_in 'note_title', with: "capybara title #{@own_note.title}"
      fill_in 'note_raw_body', with: "# capybara body\n#{@own_note.raw_body}"

      click_button 'Post'

      expect(current_path).to eql note_path(@own_note)

      expect(page).to have_content "capybara title #{@own_note.title}"
      expect(page).to have_content "capybara body"
    end

  end

  context 'edit with other user note' do
    include_context 'login'
    before do
      @note = create(:note)
    end

    it 'show note elements' do
      visit '/'

      click_link "#{@note.title}"

      expect(current_path).to eql note_path(@note)

      expect(page).not_to have_content 'Edit'
      expect(page).not_to have_content 'Connect Qiita'
      expect(page).not_to have_content 'Admin'
    end
  end

  context 'edit with connected user' do
    include_context 'login_connected_user'
    before do
      @own_note = create(:note, user:current_user)
    end

    it 'show qiita share link' do
      visit '/'

      click_link "#{@own_note.title}"

      expect(current_path).to eql note_path(@own_note)

      expect(page).to have_content 'Share Qiita'
    end
  end
end
