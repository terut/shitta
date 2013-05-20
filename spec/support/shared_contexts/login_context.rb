shared_context 'login' do
  let(:user) { create(:specify_user) }
  before do
    visit '/signin'
    fill_in 'username', with: user.username
    fill_in 'password', with: user.password
    click_button 'Sign in'
  end
end
