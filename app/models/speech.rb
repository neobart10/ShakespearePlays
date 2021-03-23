class Speech

  attr_accessor :speaker, :lines

  def initialize( speech_source )
    @speech_source = speech_source
    load_speakers
    load_lines
  end

  def load_speakers
    @speaker = @speech_source.css('SPEAKER').map(&:content)[0]
  end

  def load_lines
    @lines = @speech_source.css('LINE').map(&:content)
  end

end