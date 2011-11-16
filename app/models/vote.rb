class Vote < ActiveRecord::Base
  
  #
  # Association
  #
  belongs_to :initiative
  
  #
  # Scopes
  #
  scope :votes_up, where(:vote => 1)
  scope :votes_down, where(:vote => -1)
  
  def self.vote_up
    create(:vote => 1)
  end
  
  def self.vote_down
    create(:vote => -1)
  end
  
end
