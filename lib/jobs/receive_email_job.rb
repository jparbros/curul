class ReceiveEmailJob

  def self.perform(options)
    ReceiveEmail.new.create_comments
  end
end