class Contacto < ActionMailer::Base
  def send_email(email, nombre, comentario)
    mail(:to => 'curul501@citivox.com', :from => email, :subject => "Haz recibido un comentario de #{nombre}", :body => comentario)
  end
end
