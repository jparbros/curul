class ReceiveEmailJob

  @queue = :receive_comments

  def self.perform(options = nil)
    ReceiveEmail.new.create_comments
  end
end