class receive_email
  
  def emails
    @emails ||= client.inbox.emails(:unread).collect do |email|
      if mail.body.to_s.match(/# In Reply To \d*/).to_s.match(/\d+/).to_s.to_i
        mail = Mail.new(email.body)
        { body: mail.body.to_s.match(/^.*\r\n\r\n/).to_s.gsub(/\r\n/,''),
          from: email.from
          reply_to: mail.body.to_s.match(/# In Reply To \d*/).to_s.match(/\d+/).to_s.to_i
        }
      end
    end
  end
  
  def create_comments
    emails.each do |email|
      representative = Representative.find_by_email email[:from]
      comment = (representative.nil?) ? representative.comments.new : Comment.new
      comment.author = (representative.nil?) ? representative.name : email[:from]
      comment.comment = email.body
      comment.reply_to = email[:reply_to]
      comment.save
    end
    Representative.find_by_email
  end
  
  def client
    @gmail ||= Gmail.new('curul501@citivox.com', 'curulc1t1v0x')
  end
end