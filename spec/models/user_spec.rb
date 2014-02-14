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
      end

      context 'email' do
        it 'gmail alias is valid' do
          @user.attributes = { email: 'terut.dev+try@gmail.com' }
          expect(@user).to be_valid
        end
      end
    end
  end

  describe '#save_reset_token' do
    before do
      @user = create(:user)
      @user.save_reset_token
    end

    it { @user.reset_token.should_not be_nil }
    it { @user.reset_token_expired_at.should_not be_nil }
  end

  describe '#reset_password' do
    before do
      @user = create(:reset_token_user)
    end

    context 'when password is valid' do
      it { @user.reset_password("aaaa", "aaaa").should be_true }
      it 'reset_token and reset_token_expired_at is null after reset_password' do
        @user.reset_password("aaaa", "aaaa")
        @user.reload
        @user.reset_token.should be_nil
        @user.reset_token_expired_at.should be_nil
      end
    end

    context 'when password is invalid' do
      it { @user.reset_password("bbbb", "bbb").should be_false }
      it 'reset_token and reset_token_expired_at is not null after reset_password' do
        @user.reset_password("bbb", "bbb")
        @user.reload
        @user.reset_token.should_not be_blank
        @user.reset_token.should_not be_blank
      end
    end
  end

  describe '#owner?' do
    let(:user) { create(:user) }
    let(:owner_note) { create(:note, user: user) }
    let(:note) { create(:note) }

    context 'when model is nil' do
      it { user.owner?(nil).should be_false}
    end
    context 'when user_id method undefined with model' do
      it { user.owner?(Object.new).should be_false }
    end
    context 'when user_id is different' do
      it { user.owner?(note).should be_false }
    end
    context 'when user_id is same' do
      it { user.owner?(owner_note).should be_true }
    end
  end

  describe '#connected?' do
    context 'when connected user' do
      let(:connected_user) { create(:connected_user) }
      it { connected_user.connected?.should be_true }
    end
    context 'when unconnected user' do
      let(:user) { create(:user) }
      it { user.connected?.should be_false }
    end
  end

  describe '#service_token' do
    context 'when connected user' do
      let(:connected_user) { create(:connected_user) }
      it { connected_user.service_token.should be_kind_of(String) }
    end
    context 'when unconnected user' do
      let(:user) { create(:user) }
      it { user.service_token.should be_nil }
    end
  end
end
