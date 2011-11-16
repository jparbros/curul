class RegionesController < ApplicationController
  def show
    @region = Region.find(params[:id])
    @partidos_politicos = PoliticalParty.all
  end
end
