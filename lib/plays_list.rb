require 'nokogiri'
require 'open-uri'

class PlaysList
  def initialize
    @url = "http://www.ibiblio.org/xml/examples/shakespeare/"
  end

  def get
    self
  end

  def list
    extract_names_and_urls = lambda do |doc|
      [extract_url(@url, doc), extract_titles(doc)]
    end
    
    html.css('a').map(&extract_names_and_urls)
  end

  def html
    response = URI.open(@url)
    @html = Nokogiri::HTML(response.read)
  end

  def extract_url(url, document)
    url + document['href']
  end

  def extract_titles(document)
    document.text
  end

  def total_plays
    plays = html.css('a').map(&:content)
    return plays.size
  end

end
