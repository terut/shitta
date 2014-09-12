require 'rails_helper'

RSpec.describe 'connect qiita' do
  context 'qiita use is collect' do
    include_context 'login'

    before do
      allow(Qiita).to receive(:new) { double('qiita', url_name: 'test', token: '098f6bcd4621d373cade4e832627b4f6') }
    end

    it 'connect and disconnect' do
      visit services_path

      fill_in 'username', with: 'test'
      fill_in 'password', with: 'test'

      click_button 'Connect'

      expect(page).to have_content 'Disconnect'

      click_link 'Disconnect'

      expect(page).to have_content 'Connect Qiita Account'
    end
  end
end
