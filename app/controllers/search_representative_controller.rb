class SearchRepresentativeController < ApplicationController

  def create
    @representantes = RepresentativeSearch.new(params[:search], params[:page]).representatives.group_by(&:political_party)
    @regiones = Region.all
    @partidos_politicos = PoliticalParty.all
  end
  
end
