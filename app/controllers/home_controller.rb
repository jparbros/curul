class HomeController < ApplicationController
  
  def show
    @search = Initiative.search
    @iniciativa = Initiative.main.first
  end
end
