RSpec.shared_context 'login_flow' do
  before do
    visit '/signin'
    fill_in 'username', with: current_user.username
    fill_in 'password', with: current_user.password

    click_button 'Sign in'
  end
end

RSpec.shared_context 'login' do
  let(:current_user) { create(:specify_user) }
  include_context 'login_flow'
end

RSpec.shared_context 'login_connected_user' do
  let(:current_user) { create(:connected_specify_user) }
  include_context 'login_flow'
end
