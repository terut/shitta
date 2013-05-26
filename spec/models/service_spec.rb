require 'spec_helper'

describe Service do
  describe '#save_with_api' do
    let(:service) { create(:user).services.build }
    subject { service.save_with_api('test', 'test') }

    context 'qiita user is collect' do
      before do
        Qiita.stub(:new) { double('qiita', url_name: 'test', token: '098f6bcd4621d373cade4e832627b4f6') }
      end

      it { should be_true }
    end

    context 'qiita user is not collect' do
      before do
        Qiita.stub(:new) { raise Qiita::BadRequest }
      end

      it { should be_false }
    end
  end
end
