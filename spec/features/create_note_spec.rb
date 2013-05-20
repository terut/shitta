# coding: utf-8
require 'spec_helper'

describe 'create note' do
  context 'create' do
    include_context 'login'

    it 'success' do
      visit '/'

      click_link 'Post Note'

      current_path.should == new_note_path

      fill_in 'note_title', with: 'aaa'
      fill_in 'note_raw_body', with: "# h1タグです\n## h2タグです"

      click_button 'Post'

      page.should have_content 'aaa'
    end
  end
end
