require 'spec_helper'
require 'nokogiri'

describe PlayAnalyzer do

  # define what should be source_type with let(:source_type) { ... }
  subject { PlayAnalyzer.new(XmlSource.new("./spec/fixtures/macbeth.xml")) }

  describe '#characters' do
    it 'returns Macbeth characters' do
      expect(subject.characters).to include('MACBETH', 'BANQUO', 'DUNCAN')
    end
  end

  describe '#characters_spoken_lines' do
    it 'returns lines spoken by characters' do
      expected = [
        ['MACBETH', 719], ['BANQUO', 113], ['DUNCAN', 70]
      ]
      expect(subject.characters_spoken_lines.to_a).to include(*expected)
    end
  end

  describe '#words_by_characters' do
    it 'returns words and its frequency spoken by a given character' do
      results = subject.words_by_characters('MACBETH')
      expect(results).to include(["they", 24], ["thy", 24])
    end
  end

  describe '#scene_by_act' do
    it 'returns scenes by acts of play' do
      results = subject.scene_by_act('ACT I')
      expected = ['SCENE I.  A desert place.', 'SCENE IV.  Forres. The palace.']
      expect(results).to include(*expected)
    end
  end

  describe '#speakers_by_scene' do
    it 'returns speakers by scene of act' do
      results = subject.speakers_by_scene('ACT I', 'SCENE I.  A desert place.')
      expected = ['First Witch', 'ALL', 'Second Witch']
      expect(results).to include(*expected)
    end
  end

  describe '#lines_by_acts' do
    it 'returns total lines by acts' do
      results = subject.lines_by_acts
      expect(results).to include(["ACT I", 535], ["ACT II", 395])
    end
  end

end
