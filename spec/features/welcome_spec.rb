require 'rails_helper'

RSpec.describe 'welcome' do
  context 'signup' do
    let(:user) { build(:specify_user) }
    it 'success' do
      visit '/'
      expect(page).to have_content '社内用技術情報共有サービス'

      click_link 'Sign up'

      expect(current_path).to eql signup_path

      fill_in 'user_username', with: user.username
      fill_in 'user_email', with: user.email
      fill_in 'user_password', with: user.password
      fill_in 'user_password_confirmation', with: user.password_confirmation

      click_button 'Create an account'

      expect(current_path).to eql root_path

      expect(page).to have_content 'Notes Feed'
    end
  end

  context 'signin' do
    let(:user) { create(:specify_user) }
    it 'success' do
      visit '/'
      expect(page).to have_content '社内用技術情報共有サービス'

      click_link 'Sign in'

      expect(current_path).to eql signin_path

      fill_in 'username', with: user.username
      fill_in 'password', with: user.password

      click_button 'Sign in'

      expect(current_path).to eql root_path

      expect(page).to have_content 'Notes Feed'
    end
  end
end
