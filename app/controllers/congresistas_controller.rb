class CongresistasController < ApplicationController

  def index
    @regiones = Region.all
    @partidos_politicos = PoliticalParty.political_parties
    @representantes = Representative.actual_legislature.most_commented.limit(5)
  end

  def show
    @representante = Representative.find(params[:id])
    @comment = @representante.comments.build
    @comments = @representante.comments.approved
  end
end