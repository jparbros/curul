class IniciativasController < ApplicationController
  
  def index
    @search = Initiative.search(params[:search])
    @iniciativas = @search.page(params[:page])
    @temas = Topic.all
  end
  
  def show
    @iniciativa = Initiative.find(params[:id])
  end
end
