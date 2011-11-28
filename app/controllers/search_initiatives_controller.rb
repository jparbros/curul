class SearchInitiativesController < ApplicationController
  
  def create
    @query = params[:search]
    @iniciativas = InitiativeSearch.new(@query, params[:page]).initiatives
    @temas = Topic.all
    render 'iniciativas/index'
  end
end
