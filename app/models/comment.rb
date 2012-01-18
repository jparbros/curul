class Comment < ActiveRecord::Base
  
  #
  # Associations
  #
  belongs_to :commentable, :polymorphic => true, :counter_cache => true
  
  
  #
  # Scopes
  #
  scope :approved, where(:approved => true)
  scope :favor, where(:tendency => 1)
  scope :against, where(:tendency => -1)
  
  #
  # Validations
  #
  validates :author, :presence => true
  validates :comment, :presence => true
  
  #
  # Callbacks
  #
  after_create :publish, :send_email
  
  def self.create_approved(comment)
    self.create(comment.merge({:approved => true}))
  end
  
  def publish
    publisher = Publisher.new(self.comment)
    publisher.publish
  end
  
  def send_email
    Comentario.send_email(self.author, self).deliver if self.commentable_type == 'Representative'
  end
  
  def replies
    Comment.where("reply_to IS NOT NULL AND reply_to = ?", id)
  end
end
