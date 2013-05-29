# coding: utf-8
require 'spec_helper'

describe Note do
  describe 'validates' do
    it 'collect values is valid' do
      note = build(:note)
      note.should be_valid
    end
    context 'title' do
      it 'blank is invalid' do
        note = build(:note, title: "")
        note.should be_invalid
      end
      it 'nil is invalid' do
        note = build(:note, title: nil)
        note.should be_invalid
      end
    end
    context 'raw_body' do
      it 'blank is invalid' do
        note = build(:note, raw_body: "")
        note.should be_invalid
      end
      it 'nil is invalid' do
        note = build(:note, raw_body: "")
        note.should be_invalid
      end
    end
  end

  describe '#shared?' do
    context 'when note is shared' do
      let(:shared_note) { create(:shared_note) }
      it { shared_note.shared?.should be_true }
    end
    context 'when note is not shared' do
      let(:note) { create(:note) }
      it { note.shared?.should be_false }
    end
  end

  describe '#share' do
    let(:user) { create(:user) }
    let(:connected_user) { create(:connected_user) }
    let(:shared_note) { create(:shared_note, user: connected_user) }
    let(:note) { create(:note, user: connected_user) }
    let(:qiita_response) { { "uuid" => shared_note.uuid } }
    let(:qiita) { mock('qiita', token: '098f6bcd4621d373cade4e832627b4f6') }
    before do
      Qiita.stub(:new) { qiita }
    end

    context 'when values are collect' do
      before do
        qiita.stub(:post_item).and_return(qiita_response)
        qiita.stub(:update_item).and_return(qiita_response)
      end
      it { note.share(connected_user).should be_true }
      it { shared_note.share(connected_user).should be_true }
    end

    context 'when qitta sharing is fail' do
      before do
        qiita.stub(:post_item) { raise Qiita::BadRequest }
        qiita.stub(:update_item) { raise Qiita::BadRequest }
      end
      it { note.share(connected_user).should be_false }
      it { shared_note.share(connected_user).should be_false }
    end

    context 'when user is not connect' do
      it { note.share(user).should be_false }
    end

    context 'when note is shared' do
      it 'call qiita update_item' do
        qiita.should_receive(:update_item).with(kind_of(String), kind_of(Hash))
        shared_note.share(connected_user)
      end

      it 'call qiita post_item' do
        qiita.should_receive(:post_item).with(kind_of(Hash))
        note.share(connected_user)
      end
    end
  end

  describe "private #shared_options" do
    let(:note) { build(:note) }
    it { expect(note.__send__(:shared_items)).to include( private: true) }
  end
end
