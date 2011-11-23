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
  # Validations
  #
  validates :author, :presence => true
  validates :comment, :presence => true
  
  #
  # Callbacks
  #
  after_create :publish, :send
  
  def self.create_approved(comment)
    self.create(comment.merge({:approved => true}))
  end
  
  def publish
    publisher = Publisher.new(self.comment)
    publisher.publish
  end
  
  def send
    Comentario.send_email(self.author, self.comment, self.commentable.email).deliver if self.commentable_type == 'Representative'
  end
end
