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

      page.should have_content 'Edit'
      page.should have_content 'Connect Qiita'

      click_link 'Edit'

      current_path.should == edit_note_path(@own_note)

      fill_in 'note_title', with: "capybara title #{@own_note.title}"
      fill_in 'note_raw_body', with: "# capybara body\n#{@own_note.raw_body}"

      click_button 'Post'

      current_path.should == note_path(@own_note)

      page.should have_content "capybara title #{@own_note.title}"
      page.should have_content "capybara body"
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

      current_path.should == note_path(@note)

      page.should_not have_content 'Edit'
      page.should_not have_content 'Connect Qiita'
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

      current_path.should == note_path(@own_note)

      page.should have_content 'Share Qiita'
    end
  end
end
