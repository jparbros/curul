class ReceiveEmailJob

  @queue = :ReceiveComments

  def self.perform(options = nil)
    ReceiveEmail.new.create_comments
  end
end