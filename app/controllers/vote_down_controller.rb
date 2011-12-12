class VoteDownController < ApplicationController
  
  def create
    @iniciativa = Initiative.find(params[:iniciativa_id])
    @iniciativa.votes.vote_down
    cookies["voted_#{@iniciativa.id}"] = true
    redirect_to request.env["HTTP_REFERER"] + '?voted=true&voto=contra'
  end
end
