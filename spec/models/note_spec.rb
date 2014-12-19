require 'rails_helper'

RSpec.describe Note do
  describe 'validates' do
    it 'collect values is valid' do
      note = build(:note)
      expect(note).to be_valid
    end
    context 'title' do
      it 'blank is invalid' do
        note = build(:note, title: "")
        expect(note).to be_invalid
      end
      it 'nil is invalid' do
        note = build(:note, title: nil)
        expect(note).to be_invalid
      end
    end
    context 'raw_body' do
      it 'blank is invalid' do
        note = build(:note, raw_body: "")
        expect(note).to be_invalid
      end
      it 'nil is invalid' do
        note = build(:note, raw_body: "")
        expect(note).to be_invalid
      end
    end
  end

  describe '#create' do
    context 'when note add new tag' do
      it 'tags_count is 1' do
        note = create(:note_with_tags, tags_count: 1)
        tag = Tag.find_by_id(note.tags[0].id)
        expect(tag.taggings_count).to eql 1
      end
    end
  end

  describe '#update' do
    context 'when note remove tag' do
      it 'tags_count is 0' do
        note = create(:note_with_tags, tags_count: 1)
        tag = note.tags[0]
        note.tag_list = "new_tag"
        note.save
        remove_tag = Tag.find_by_id(tag.id)
        expect(remove_tag.taggings_count).to eql 0
      end
    end
  end

  describe '#tag_list=' do
    subject(:note) { build(:note) }
    context 'when tag_list is nil' do
      it 'tags is empty' do
        note.tag_list = nil
        expect(note.tags.empty?).to be true
      end
    end

    context 'when tag_list is ""' do
      it 'tags is empty' do
        note.tag_list = ""
        expect(note.tags.empty?).to be true
      end
    end

    context 'when tag_list is " aaa ,　 bbb,  ccc "' do
      let(:tag_list) { " aaa ,　 bbb,  ccc " }
      it 'tags.size is 3' do
        note.tag_list = tag_list
        expect(note.tags.size).to eql 3
      end
      it 'tags has aaa, bbb and ccc' do
        note.tag_list = tag_list
        expect(note.tags.map(&:name)).to eql ["aaa", "bbb", "ccc"]
      end
    end

    context 'when tag_list is "aaa, BBB, Arch_Linux, bbb' do
      let(:tag_list) { "aaa, BBB, Arch_Linux, bbb" }
      it 'tags has downcase name' do
        note.tag_list = tag_list
        expect(note.tags.map(&:name)).to eql ["aaa", "bbb", "arch_linux"]
      end

      it 'tags is uniq' do
        note.tag_list = tag_list
        expect(note.tags.map(&:name)).to eql ["aaa", "bbb", "arch_linux"]
      end
    end

    context "when tag_list is 5 words" do
      it 'valid return true' do
        note.tag_list = "aaa,bbb,ccc,ddd,eee"
        expect(note.valid?).to be true
      end

      it 'tags can update' do
        note = create(:note_with_tags, tags_count: 5) 
        tag_names = note.tags.map(&:name).sample(3)
        note.tag_list = "#{tag_names.join(",")}, add1, add2"
        expect(note.valid?).to be true
      end

      it 'updated tags is corrent' do
        note = create(:note_with_tags, tags_count: 5) 
        tag_names = note.tags.map(&:name).sample(3)
        tag_names += ["add1", "add2"]
        note.tag_list = tag_names.join(",")
        note.save
        expect(note.tags.map(&:name) - tag_names).to be_empty
      end
    end

    context "when tag_list is 6 words" do
      it 'valid return false' do
        note.tag_list = "aaa,bbb,ccc,ddd,eee,fff"
        expect(note.valid?).to be false
      end
    end

    context "when tag_list is 30 characters" do
      it 'valid return true' do
        note.tag_list = "#{"a"*30}"
        expect(note.valid?).to be true
      end
    end

    context "when tag_list is 31 characters" do
      it 'valid return false' do
        note.tag_list = "#{"a"*31}"
        expect(note.valid?).to be false
      end
    end
  end

  describe '#shared?' do
    context 'when note is shared' do
      let(:shared_note) { create(:shared_note) }
      it { expect(shared_note.shared?).to be true }
    end
    context 'when note is not shared' do
      let(:note) { create(:note) }
      it { expect(note.shared?).to be false }
    end
  end

  describe '#share' do
    let(:user) { create(:user) }
    let(:connected_user) { create(:connected_user) }
    let(:shared_note) { create(:shared_note, user: connected_user) }
    let(:note) { create(:note, user: connected_user) }
    let(:qiita) { double('qiita', token: '098f6bcd4621d373cade4e832627b4f6') }
    before do
      allow(Qiita).to receive_messages(:new => qiita)
    end

    context 'when values are collect' do
      before do
        res = { "uuid" => attributes_for(:shared_note)['uuid'] }
        allow(qiita).to receive(:post_item) { res }
        allow(qiita).to receive(:update_item) { res }
      end
      it { expect(note.share(connected_user)).to be_truthy }
      it { expect(shared_note.share(connected_user)).to be_truthy }
    end

    context 'when qitta sharing is fail' do
      before do
        allow(qiita).to receive(:post_item) { raise Qiita::BadRequest }
        allow(qiita).to receive(:update_item) { raise Qiita::BadRequest }
      end

      it { expect(note.share(connected_user)).to be_falsey }
      it { expect(shared_note.share(connected_user)).to be_falsey }
    end

    context 'when user is not connect' do
      it { expect(note.share(user)).to be_falsey }
    end

    context 'when note is shared' do
      it 'call qiita update_item' do
        expect(qiita).to receive(:update_item).with(kind_of(String), kind_of(Hash))
        shared_note.share(connected_user)
      end

      it 'call qiita post_item' do
        expect(qiita).to receive(:post_item).with(kind_of(Hash))
        note.share(connected_user)
      end
    end
  end

  describe ".search" do
    before do
      @note = create(:note_with_tags, raw_body: "good job\nthank you.")
    end

    context 'when query is nil, blank, em space' do
      it 'result count is 1' do
        expect(Note.search(nil).size).to be 1
      end
    end

    context 'when query is nil, blank, em space' do
      it 'result count is 1' do
        expect(Note.search(' ').size).to be 1
      end
    end

    context 'when query is nil, blank, em space' do
      it 'result count is 1' do
        expect(Note.search('　').size).to be 1
      end
    end

    context "when query is 'good job'" do
      it 'return ActiveRelation' do
        expect(Note.search('good job')).to be_kind_of ActiveRecord::Relation
      end

      it 'result count is 1' do
        expect(Note.search('good job').size).to eql 1
      end
    end
  end

  describe "private #shared_options" do
    let(:note) { build(:note) }
    it { expect(note.__send__(:shared_items)).to include( private: true) }
  end
end
