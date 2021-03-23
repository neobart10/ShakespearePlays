require 'spec_helper'

describe PlaysList do
  before do
    path = "spec/fixtures/list.html"
    response = File.new(path).read
    stub_request(:get, /.*www.ibiblio.org.*/).to_return(body: response)
  end

  subject { PlaysList.new.get }

  describe '#list' do
    it 'returns play list' do
      expected = [
        ["http://www.ibiblio.org/xml/examples/shakespeare/all_well.xml", "All's Well That Ends Well"],
        ["http://www.ibiblio.org/xml/examples/shakespeare/as_you.xml", "As You Like It"]
      ]
      expect(subject.list).to include(*expected)
    end
  end

  describe '#total_plays' do
    it 'return total plays' do
      expect(subject.total_plays).to eq(39)
    end
  end
end
