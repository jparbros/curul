class IniciativasController < ApplicationController
  
  def index
    @search = Initiative.search(params[:search])
    @iniciativas = @search.page(params[:page])
    @temas = Topic.all
  end
  
  def show
    @search = Initiative.search(params[:search])
    @iniciativa = Initiative.find(params[:id])
    @temas = Topic.all
  end
end
