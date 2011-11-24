class IniciativasController < ApplicationController
  
  def index
    @iniciativas = Initiative.page(params[:page])
    @temas = Topic.all
  end
  
  def show
    @iniciativa = Initiative.find(params[:id])
    @temas = Topic.all
  end
end
