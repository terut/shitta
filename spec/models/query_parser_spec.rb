require 'rails_helper'

RSpec.describe QueryParser do
  describe '.parse' do
    it 'return empty array when query is nil' do
      expect(QueryParser.parse(nil)).to be_empty
    end

    it 'return empty array when query is blank' do
      expect(QueryParser.parse('')).to be_empty
    end

    it 'return empty array when query is only em space' do
      expect(QueryParser.parse('　')).to be_empty
    end

    it '% and _ of query are escaped' do
      expect(QueryParser.parse('100% good_job')).to match(["100\\%", "good\\_job"])
    end

    it 'work with em space' do
      expect(QueryParser.parse('　 good 　job 　')).to contain_exactly('good', 'job')
    end
  end
end
