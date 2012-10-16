class Comment < ActiveRecord::Base

  #
  # Associations
  #
  belongs_to :commentable, :polymorphic => true, :counter_cache => true
  belongs_to :legislature


  #
  # Scopes
  #
  scope :approved, where(:approved => true)
  scope :favor, where(:tendency => 1)
  scope :against, where(:tendency => -1)
  scope :actual_legislature, where(:legislature_id => (Legislature.active ? Legislature.active.id : nil))

  #
  # Validations
  #
  validates :author, :presence => true
  validates :comment, :presence => true

  #
  # Callbacks
  #
  after_create :send_email
  before_create :assign_legislature

  #
  # Pagination
  #
  paginates_per 10
  
  searchable do
    time :created_at, stored: true
    string :author, stored: true
    time :creation_day, stored: true do
      created_at.to_date
    end
  end

  def self.create_approved(comment)
    self.create(comment.merge({:approved => true}))
  end
  
  def approve!
    self.approved = true
    save
  end
  
  def unapprove!
    self.approved = false
    save
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

  def assign_legislature
    self.legislature_id = Legislature.active.id
  end
  
  #
  # Search methods
  #
  
  def self.last_10_days_count
    counter = []
    (1..10).each do |day_ago|
      counter << [(day_ago.day.ago.to_i - 18000000),  where(created_at: day_ago.day.ago.beginning_of_day..day_ago.day.ago.end_of_day).count]
    end
    counter
  end
end
