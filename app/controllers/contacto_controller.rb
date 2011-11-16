class ContactoController < ApplicationController
  
  def new
    @contacto = ContactForm.new
  end
  
  def create
    @contacto = ContactForm.new params[:contact_form]
    if @contacto.valid?
      Contacto.send_email(@contact_form.email, @contact_form.nombre, @contact_form.comentario).deliver
      redirect_to :action => :new, :notice => 'Email enviado, pronto recibiras respuesta.'
    else
      render :new
    end
  end
end
