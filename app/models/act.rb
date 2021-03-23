require_relative './scene'

class Act
  attr_accessor :document, :title, :scenes

  def initialize(document)
    @document = document
    load_title
    load_scenes
  end

  def load_title
    @title = document.css('TITLE').map(&:content)[0]
  end

  def load_scenes
    @scenes = document.css('SCENE').map do |scene_document|
      Scene.new scene_document
    end
  end

  def total_lines
    lines = 0
    scenes.each do |scene|
     scene.speeches.each do |speech|
        lines += speech.lines.size
      end
    end
    return lines
  end

end