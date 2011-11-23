class Comentario < ActionMailer::Base
  default from: "comentarios@curul501.org"
  
  def send_email(nombre, comentario, email = nil)
    to_emails = ['info@citivox.com', 'curul501@fundar.org.mx','jparbros@gmail.com']
    to_emails << email if email
    mail(:to => [], :from => email, :subject => "Haz recibido un comentario de #{nombre}", :body => "#{nombre} comenta: \n #{comentario}")
  end
end
