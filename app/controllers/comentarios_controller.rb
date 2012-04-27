class ComentariosController < ApplicationController
  def create
    @representante = Representative.find(params[:congresista_id])
    if params[:other_email].blank? && @representante.comments.create_approved(params[:comment])
      redirect_to :back, :notice => "Comentario creado exitosamente"
    else
      redirect_to :back, :alert => "Comentario fallo al crearse"
    end
  end

end
