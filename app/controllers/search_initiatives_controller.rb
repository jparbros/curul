class SearchInitiativesController < ApplicationController
  
  def create
    @iniciativas = InitiativeSearch.new(params[:search], params[:page]).initiatives
    @temas = Topic.all
    render 'iniciativas/index'
  end
end
