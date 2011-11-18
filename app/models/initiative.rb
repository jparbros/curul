class Initiative < ActiveRecord::Base
  #
  # Associations
  #
  has_many :comments, :as => :commentable, :dependent => :destroy
  has_many :votes
  has_and_belongs_to_many :topics
  belongs_to :representative
  
  #
  # Attributes
  #
  attr_reader :topic_tokens, :presented_by_token
  
  #
  # Scope
  #
  scope :main, where(:main => true)
  
  #
  # Pagination
  #
  paginates_per 5

  #
  # States Machine
  #
  state_machine :state, :initial => :new do
    state :new
    state :presentation
    state :commission
    state :plenary
    state :project
    
    event :in_presentation do
      transition :to => :presentation, :from => :any
    end
    
    event :in_commission do
      transition :to => :commission, :from => :any
    end
    
    event :in_plenary do
      transition :to => :plenary, :from => :any
    end
    
    event :in_project do
      transition :to => :project, :from => :any
    end
  end
  
  def topic_tokens=(ids)
    self.topic_ids = ids.split(',') 
  end
  
  def presented_by_token=(id)
    self.representative_id = id
  end
  
  def official_percentage_up
    p1 = (((official_vote_up.to_f*100)/total_official_votes))
    p1.nan? ? 0 : p1.round
  end
  
  def official_percentage_down
    p1 = ((official_vote_down.to_f*100)/total_official_votes)
    p1.nan? ? 0 : p1.round
  end
  
  def official_pixel_votes_up
    ((official_percentage_up.to_f/100)*383).to_i
  end
  
  def official_pixel_votes_down
    ((official_percentage_down.to_f/100)*383).to_i
  end
  
  def total_official_votes
    official_vote_up + official_vote_down
  end
  
  def official_voted?
    official_vote_up > 0 && official_vote_down > 0
  end
  
  def percentage_votes_up
    if votes_up > 0
      ((votes_up.to_f*100)/total_votes).round
    else
      0
    end
  end
  
  def percentage_votes_down
    if votes_down > 0
      ((votes_down.to_f*100)/total_votes).round
    else
      0
    end
  end
  
  def pixel_votes_up
    if votes_up > 0
      ((percentage_votes_up.to_f/100)*383).to_i
    else
      0
    end
  end
  
  def pixel_votes_down
    if votes_down > 0
      ((percentage_votes_down.to_f/100)*383).to_i
    else
      0
    end
  end
  
  def total_votes
    votes.count
  end
  
  def votes_up
    votes.votes_up.count
  end
  
  def votes_down
    votes.votes_down.count
  end
  
  def voted?
    votes_up > 0 || votes_down > 0
  end
end
