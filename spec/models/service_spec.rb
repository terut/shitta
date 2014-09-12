require 'rails_helper'

RSpec.describe Service do
  describe '#save_with_api' do
    let(:service) { create(:user).services.build }
    subject { service.save_with_api('test', 'test') }

    context 'qiita user is collect' do
      before do
        allow(Qiita).to receive_messages(:new => double('qiita', url_name: 'test', token: '098f6bcd4621d373cade4e832627b4f6'))
      end

      it { is_expected.to be_truthy }
    end

    context 'qiita user is not collect' do
      before do
        # TODO Fix syntax
        allow(Qiita).to receive(:new) { raise Qiita::BadRequest }
      end

      it { is_expected.to be_falsey }
    end
  end
end
