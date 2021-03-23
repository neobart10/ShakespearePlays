require '../lib/http_source'
require '../lib/xml_source'
require '../app/models/play'

class PlayAnalyzer

  def initialize(source_type)
    @source_type = source_type
    @source      = source_type.source
    @play = Play.new(@source_type)
  end

  def words_by_characters(character)
    @play.words_by_character(character).to_a
  end

  def characters
    @play.characters.to_a
  end

  def characters_spoken_lines
    @play.characters.map do |c|
      [c, @play.lines_by_character(c)]
    end
  end

  def scene_by_act(act_title)
    acts = @play.acts.select do |act|
      act.title == act_title
    end
    acts[0].scenes.map do |scene|
      scene.title
    end
  end

  def speakers_by_scene(act_title, scene_title)
    acts = @play.acts.select do |act|
      act.title == act_title
    end
    scenes = acts[0].scenes.select do |scene|
      scene.title == scene_title
    end
    scenes[0].speeches.map do |speech|
      speech.speaker
    end
  end

  def lines_by_acts
    @play.acts.map do |act|
      [act.title, act.total_lines]
    end
  end

end

#source = HttpSource.new("http://www.ibiblio.org/xml/examples/shakespeare/macbeth.xml")
#source = XmlSource.new("../spec/fixtures/macbeth.xml")
#play_analyzer = PlayAnalyzer.new(source)
#puts play_analyzer.lines_by_acts
#puts play_analyzer.speakers_by_scene('ACT I', 'SCENE I.  A desert place.')
#puts play_analyzer.characters
#puts play_analyzer.words_by_characters 'MACBETH'
#puts play_analyzer.scene_by_act('ACT I')
#puts play_analyzer.characters_spoken_lines