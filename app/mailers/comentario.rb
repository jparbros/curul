class Comentario < ActionMailer::Base
  default from: "comentarios@curul501.org",
          reply_to: 'curul501@citivox.com'
  
  def send_email(nombre, comentario, email = nil)
    to_emails = ['info@citivox.com', 'curul501@fundar.org.mx','jparbros@gmail.com']
    to_emails << email if email
    @data_email = {nombre: nombre, comentario: comentario}
    mail(:to => to_emails, :subject => "Has recibido un comentario de #{nombre}")
  end
end
