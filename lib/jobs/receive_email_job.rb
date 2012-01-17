class ReceiveEmailJob

  @queue = :ReceiveComments

  def self.perform(options = nil)
    begin
      ReceiveEmail.new.create_comments
    rescue Exception => e
      Airbrake.notify e
    end
  end
end