require "#{Rails.root}/lib/plays_list"

class HomeController < ApplicationController
  def index
    @plays = PlaysList.new.list
  end

end
