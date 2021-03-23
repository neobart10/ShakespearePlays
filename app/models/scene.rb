require_relative './speech'

class Scene
  attr_accessor :document, :title, :speeches

  def initialize(document)
    @document = document
    load_title
    load_speeches
  end

  def load_title
    @title = document.css('TITLE').map(&:content)[0]
  end

  def load_speeches
    @speeches = document.css('SPEECH').map do |speech_document|
      Speech.new speech_document
    end
  end

end