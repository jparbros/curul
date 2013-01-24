class SearchInitiativesController < ApplicationController
  
  def create
    @query = params[:search].merge(params[:page] || {})
    @iniciativas_response = Initiative.filters(@query)
    @iniciativas = @iniciativas_response.results
    @temas = Topic.all
    @query = @query.delete_if {|key, value| value.blank? }
    render 'iniciativas/index'
  end
end
