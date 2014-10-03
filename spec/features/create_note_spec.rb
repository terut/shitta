require 'rails_helper'

RSpec.describe 'create note' do
  before do
    allow_any_instance_of(Note).to receive(:post_notify)
  end

  context 'create' do
    include_context 'login'

    it 'success' do
      visit '/'

      click_link 'Post Note'

      expect(current_path).to eql new_note_path

      fill_in 'note_title', with: 'aaa'
      fill_in 'note_raw_body', with: "# h1タグです\n## h2タグです"

      click_button 'Post'

      expect(page).to have_content 'aaa'
    end
  end
end
