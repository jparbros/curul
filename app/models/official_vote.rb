class OfficialVote < ActiveRecord::Base
  
  #
  # Associations
  #
  belongs_to :initiative
  belongs_to :political_party
  
  def percentage
    ((votes.to_i * 100)/initiative.official_vote_up.to_i)
  end
end
