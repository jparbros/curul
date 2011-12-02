class PartidoPoliticoController < ApplicationController
  
  def show
    @political_party = PoliticalParty.find(params[:id])
  end
end
