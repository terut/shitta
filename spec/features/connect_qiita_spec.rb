# coding: utf-8
require 'spec_helper'

describe 'connect qiita' do
  context 'qiita use is collect' do
    include_context 'login'

    before do
      Qiita.stub(:new) { double('qiita', url_name: 'test', token: '098f6bcd4621d373cade4e832627b4f6') }
    end

    it 'connect and disconnect' do
      visit services_path

      fill_in 'username', with: 'test'
      fill_in 'password', with: 'test'

      click_button 'Connect'

      page.should have_content 'Disconnect'

      click_link 'Disconnect'

      page.should have_content 'Connect Qiita Account'
    end
  end
end
