# coding: utf-8
require 'spec_helper'

describe 'edit_note' do
  context 'edit with own note' do
    include_context 'login'
    before do
      @own_note = create(:note, user:current_user)
    end
    it 'success' do
      visit '/'

      click_link "#{@own_note.title}"

      current_path.should == note_path(@own_note)

      page.should have_content 'Comment'

      fill_in 'comment_raw_body', with: "# capybara comment raw body"

      click_button 'Post'

      page.should have_content 'capybara comment raw body'
    end
  end
end
