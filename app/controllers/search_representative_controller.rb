class SearchRepresentativeController < ApplicationController

  def create
    @representantes = Representative.filters(params[:search]).results.group_by(&:political_party)
    @regiones = Region.all
    @partidos_politicos = PoliticalParty.all
  end
  
end
