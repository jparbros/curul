class Comisiones::IniciativasController < ApplicationController
  def index
  end

  def show
    @commission = Commission.find(params[:id])
    @query = {:commission => @commission.name}
    @iniciativas = InitiativeSearch.new(@query).initiatives
    @temas = Topic.all
    render 'iniciativas/index'
  end

end
