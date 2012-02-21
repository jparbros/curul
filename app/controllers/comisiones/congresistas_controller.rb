class Comisiones::CongresistasController < ApplicationController
  def index
  end

  def show
    @commission = Commission.find(params[:id])
    @partidos_politicos = PoliticalParty.political_parties
  end

end
