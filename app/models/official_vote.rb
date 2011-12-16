class OfficialVote < ActiveRecord::Base
  
  #
  # Associations
  #
  belongs_to :initiative
  belongs_to :political_party
  
  def percentage
    if initiative.official_vote_up > 0
      ((votes.to_i * 100)/initiative.official_vote_up.to_i)
    else
      0
    end
  end
end
