require "#{Rails.root}/lib/plays_list"
require "#{Rails.root}/lib/http_source"

class PlayController < ApplicationController
  def index
    @plays = PlaysList.new.list
    @id = params[:id].to_i
    @http = HttpSource.new(get_source_play(@id))
    @play = Play.new(@http)
  end

  private
    def get_source_play(id)
      @source = @plays[id][0]
    end
end
