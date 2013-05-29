require 'spec_helper'

describe Comment do
  describe 'validates' do
    context 'raw_body' do
      it 'blank is invalid' do
        comment = build(:comment, raw_body: "")
        comment.should be_invalid
      end

      it 'nil is invalid' do
        comment = build(:comment, raw_body: nil)
        comment.should be_invalid
      end
    end
  end
end
