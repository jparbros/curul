class CommentsController < ApplicationController
  def create
    @iniciativa = Initiative.find(params[:iniciativa_id])
    if verify_recaptcha && @iniciativa.comments.create_approved(params[:comment])
      redirect_to :back, :notice => "Comentario creado exitosamente"
    else
      redirect_to :back, :alert => "Comentario fallo al crearse"
    end
  end
end
