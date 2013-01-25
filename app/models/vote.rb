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
  if ENV['REINDEX'].blank?
    default_scope {where(site_id: Site.current_id)}
  end
  
  
  def self.vote_up
    create(:vote => 1)
  end
  
  def self.vote_down
    create(:vote => -1)
  end
  
end
