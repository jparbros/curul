class ComentaController < ApplicationController
  
  def show
    @comentario = Comment.new
    @comentarios = Comment.all
  end
  
  def create
    message = Comment.create_approved(params[:comment]) ? {:notice => 'Comentario se creo.'} : {:error => 'Error al crear el comentario.'} 
    redirect_to :back, message
  end
end
