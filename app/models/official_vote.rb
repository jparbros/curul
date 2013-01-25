class OfficialVote < ActiveRecord::Base
  
  #
  # Associations
  #
  belongs_to :initiative
  belongs_to :political_party
  
  #
  # Scopes
  #
  if ENV['REINDEX'].blank?
    default_scope {where(site_id: Site.current_id)}
  end
  
  
  
  def percentage
    if initiative.official_vote_up > 0
      ((votes.to_i * 100)/initiative.official_vote_up.to_i)
    else
      0
    end
  end
end
