# coding: utf-8
describe 'welcome' do
  context 'signup' do
    let(:user) { build(:specify_user) }
    it 'success' do
      visit '/'
      page.should have_content '社内用技術情報共有サービス'

      click_link 'Sign up'

      current_path.should == signup_path

      fill_in 'user_username', with: user.username
      fill_in 'user_email', with: user.email
      fill_in 'user_password', with: user.password
      fill_in 'user_password_confirmation', with: user.password_confirmation

      click_button 'Create an account'

      current_path.should == root_path

      page.should have_content 'Notes Feed'
    end
  end

  context 'signin' do
    let(:user) { create(:specify_user) }
    it 'success' do
      visit '/'
      page.should have_content '社内用技術情報共有サービス'

      click_link 'Sign in'

      current_path.should == signin_path

      fill_in 'username', with: user.username
      fill_in 'password', with: user.password

      click_button 'Sign in'

      current_path.should == root_path

      page.should have_content 'Notes Feed'
    end
  end
end
