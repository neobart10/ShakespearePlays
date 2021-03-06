require 'nokogiri'
require 'open-uri'

class HttpSource

  def initialize(url)
    @url = url
  end

  def source
    response = URI.open(@url)
    Nokogiri::XML(response.read)
  end

end