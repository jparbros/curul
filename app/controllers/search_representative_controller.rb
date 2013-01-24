class SearchRepresentativeController < ApplicationController

  def create
    params[:search][:page] = params[:page] if params[:page].present?
    @representantes_search = Representative.filters(params[:search])
    @representantes = @representantes_search.results.group_by(&:political_party)
    @regiones = Region.all
    @partidos_politicos = PoliticalParty.all
  end
  
end
