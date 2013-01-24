class IniciativasController < ApplicationController

  def index
    @query = {}.merge(params[:page] || {})
    @iniciativas_response = Initiative.filters(@query)
    @iniciativas = @iniciativas_response.results
    @temas = Topic.all
  end

  def show
    @iniciativa = Initiative.find(params[:id])
    @temas = Topic.all
  end
end
