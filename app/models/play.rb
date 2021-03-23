require 'nokogiri'
require 'open-uri'
require 'set'
require_relative './act'

class Play

  attr_accessor :document, :title, :characters, :acts

  def initialize(source)
    @source = source
    @document = source.source
    load_title
    load_characters
    load_acts
  end

  def lines_by_character(character)
    @lines = 0
    acts.each do |act|
      act.scenes.each do |scene|
        scene.speeches.each do |speech|
          if speech.speaker == character
            @lines += speech.lines.size
          end
        end
      end
    end
    return @lines
  end

  def words_by_character name
    words = Hash.new

    acts.each do |act|
      act.scenes.each do |scene|
        scene.speeches.each do |speech|
          if speech.speaker == name
            speech.lines.map do |line|
              line.split.each do |word|
                word = word.downcase
                if words.has_key?(word)
                  words[word] = words[word] + 1
                else
                  words[word] = 1
                end
              end
            end
          end
        end
      end
    end

    return words
  end

  private

  def load_title
    @title = document.css('TITLE').map(&:content)[0]
  end

  def load_characters
    @characters = Set.new
    document.css('SPEAKER').map do |character|
      @characters << character.text
    end
  end

  def load_acts
    @acts = document.css('ACT').map do |act_document|
      Act.new act_document
    end
  end

end