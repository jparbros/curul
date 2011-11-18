class HomeController < ApplicationController
  
  layout 'home'
  
  def show
    @search = Initiative.search
    @iniciativa = Initiative.main.first
  end
end
