class ComisionesController < ApplicationController
  
  def show
    @commission = Commission.find(params[:id])
    @partidos_politicos = PoliticalParty.all
  end
end
