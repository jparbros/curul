class CongresistasController < ApplicationController
  
  def index
    @regiones = Region.all
    @partidos_politicos = PoliticalParty.all
    @representantes = Representative.most_commented.limit(5)
  end
  
  def show
    @representante = Representative.find(params[:id])
    @comment = @representante.comments.build
    @comments = @representante.comments.approved
  end
end