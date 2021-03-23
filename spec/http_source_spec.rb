require 'spec_helper'

class StubSocket
  def close
  end
end

describe HttpSource do
  before do
    path = "spec/fixtures/macbeth.html"
    response = File.new(path).read
    stub_request(:get, /.*www.ibiblio.org./)
      .to_return(body: response)
  end

  subject { HttpSource.new("http://www.ibiblio.org/xml/examples/shakespeare/macbeth.xml") }

  describe '#source' do
    it 'returns nokogiri object' do
      expect(subject.source).to be_a Nokogiri::XML::Document
    end
  end

end
