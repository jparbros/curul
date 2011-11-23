class HomeController < ApplicationController
  
  layout 'home'
  
  def show
    @search = Initiative.search
    @iniciativa_main = Initiative.main.first
    @iniciativa = Initiative.last
  end
end
