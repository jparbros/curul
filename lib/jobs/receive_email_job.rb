class ReceiveEmailJob

  @queue = :ReceiveComments

  def self.perform(options = nil)
    begin
      ReceiveEmail.new.create_comments
    rescue Exception => e
      notify_airbrake e
    end
  end
end