class ReceiveEmailJob

  @queue = :ReceiveComments

  def self.perform(options = nil)
    ReceiveEmail.new.send_request
  end
end