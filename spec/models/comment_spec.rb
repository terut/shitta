require 'rails_helper'

RSpec.describe Comment do
  describe 'validates' do
    context 'raw_body' do
      it 'blank is invalid' do
        comment = build(:comment, raw_body: "")
        expect(comment).to be_invalid
      end

      it 'nil is invalid' do
        comment = build(:comment, raw_body: nil)
        expect(comment).to be_invalid
      end
    end
  end
end
