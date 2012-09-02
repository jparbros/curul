class Api::RepresentativesController < ApplicationController
  def show
    region = Region.find_by_slug(params[:region_name])
    representative = Representative.actual_legislature.where(district: params[:district], region_id: region.id)
    render json: (representative.present? ? representative : {error: 'No se encontro el diputado.'})
  end
end
