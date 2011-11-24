class HomeController < ApplicationController

  def show
    @iniciativa_main = Initiative.main.first
    @iniciativa = Initiative.last
  end
end
