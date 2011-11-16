class Comment < ActiveRecord::Base
  
  #
  # Associations
  #
  belongs_to :commentable, :polymorphic => true
  
  #
  # Scopes
  #
  scope :approved, where(:approved => true)
  
  #
  # Callbacks
  #
  after_create :publish
  
  def self.create_approved(comment)
    self.create(comment.merge({:approved => true}))
  end
  
  def publish
    publisher = Publisher.new(self.comment)
    publisher.publish
  end
end
