require 'spec_helper'

describe User do
  describe 'validates' do
    context 'new user' do
      context 'username' do
        it 'alphanumlic and underscore is valid' do
          @user = build(:user, username: '_az_09_')
          expect(@user).to be_valid
        end

        it 'blank is invalid' do
          @user = build(:user, username: '')
          expect(@user).to be_invalid
        end

        it 'hyphen is invalid' do
          @user = build(:user, username: '_az-09_')
          expect(@user).to be_invalid
        end

        it '\n is invalid' do
          @user = build(:user, username: '_az\n09_')
          expect(@user).to be_invalid
        end

        it 'same name is invalid' do
          @user = create(:user, username: 'samename')
          @user = build(:user, username: 'samename')
          expect(@user).to be_invalid
        end
      end

      context 'password' do
        it 'blank is invalid' do
          @user = build(:user, password: '', password_confirmation: '')
          expect(@user).to be_invalid
        end

        it 'different password is invalid' do
          @user = build(:user, password_confirmation: "test")
          expect(@user).to be_invalid
        end
      end

      context 'email' do
        it 'gmail alias is valid' do
          @user = build(:user, email: 'terut.dev+try@gmail.com')
          expect(@user).to be_valid
        end
      end
    end

    context 'present user' do
      before do
        @user = create(:user)
        @user.password = nil
        @user.password_confirmation = nil
      end

      context 'email' do
        it 'gmail alias is valid' do
          @user.attributes = { email: 'terut.dev+try@gmail.com' }
          expect(@user).to be_valid
        end
      end
    end
  end
end
