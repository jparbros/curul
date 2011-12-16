class SearchInitiativesController < ApplicationController
  
  def create
    @query = params[:search].merge(params[:date] || {})
    @iniciativas = InitiativeSearch.new(@query, params[:page]).initiatives
    @temas = Topic.all
    @query = @query.delete_if {|key, value| value.blank? }
    render 'iniciativas/index'
  end
end
