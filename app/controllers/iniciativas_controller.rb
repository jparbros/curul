class IniciativasController < ApplicationController

  def index
    @query = {}.merge({page: params[:page] || 1})
    @iniciativas_response = Initiative.filters(@query)
    @iniciativas = @iniciativas_response.results
    @temas = Topic.all
  end

  def show
    @iniciativa = Initiative.find(params[:id])
    @temas = Topic.all
  end
end
