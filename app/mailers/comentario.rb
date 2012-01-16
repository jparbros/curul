class Comentario < ActionMailer::Base
  default from: "comentarios@curul501.org",
          reply_to: 'curul501@citivox.com'
  
  def send_email(nombre, comentario)
    to_emails = ['info@citivox.com', 'curul501@fundar.org.mx','jparbros@gmail.com']
    to_emails << comentario.commentable.email if comentario.commentable and comentario.commentable.email
    @data_email = {nombre: nombre, comentario: comentario}
    mail(:to => to_emails, :subject => "Has recibido un comentario de #{nombre}")
  end
end
