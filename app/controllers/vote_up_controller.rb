class VoteUpController < ApplicationController
  def create
    @iniciativa = Initiative.find(params[:iniciativa_id])
    @iniciativa.votes.vote_up
    cookies["voted_#{@iniciativa.id}"] = true
    redirect_to request.env["HTTP_REFERER"] + '?voted=true&vota=favor'
  end
end
