class SearchRepresentativeController < ApplicationController

  def create
    @representantes = RepresentativeSearch.new(params[:search], params[:page]).representatives
    @regiones = Region.all
    @partidos_politicos = PoliticalParty.all
  end
  
end
