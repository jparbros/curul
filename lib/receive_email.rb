# encoding: utf-8

class ReceiveEmail
  def emails
    @emails = []
    client.inbox.emails(:unread).each do |email|
      mail = Mail.new(email.body.to_s.gsub("\xC3\xB1",'n'))
      if mail.body.to_s.match(/# In Reply To \d*/).to_s.match(/\d+/).to_s.to_i
        @emails << { body: mail.body.to_s.match(/^.*\r\n\r\n/).to_s.gsub(/\r\n/,''),
          from: email.from.first,
          reply_to: mail.body.to_s.match(/# In Reply To \d*/).to_s.match(/\d+/).to_s.to_i
        }
        email.mark(:read)
      end
    end
    puts @emails.inspect
    @emails
  end
  
  def create_comments
    emails.each do |email|
      representative = Representative.find_by_email email[:from]
      comment = (representative.nil?) ? Comment.new : representative.comments.new
      comment.author = (representative.nil?) ? email[:from] : representative.name
      comment.comment = email[:body]
      comment.reply_to = email[:reply_to]
      comment.approved = true
      comment.save
    end
    Representative.find_by_email
  end
  
  def send_request
    Typhoeus::Request.post('http://curul-501.herokuapp.com/api/comments')
  end
  
  def client
    @gmail ||= Gmail.new('curul501@citivox.com', 'curulc1t1v0x')
  end
end