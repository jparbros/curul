class HomeController < ApplicationController

  def show
    @iniciativas = Initiative.to_home
  end
end
