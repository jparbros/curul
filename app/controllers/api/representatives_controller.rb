class Api::RepresentativesController < ApplicationController
  def show
    region = Region.find_by_name(params[:region_name].capitalize)
    representative = Representative.where(district: params[:district], region_id: region.id)
    render json: (representative.present? ? representative : {error: 'No se encontro el diputado.'})
  end
end
