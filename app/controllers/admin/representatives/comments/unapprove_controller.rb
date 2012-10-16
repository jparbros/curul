class Admin::Representatives::Comments::UnapproveController < ApplicationController
  
  def create
    @representative = Representative.find params[:representative_id]
    @comment = @representative.comments.find params[:comment_id]
    @comment.unapprove!
    redirect_to admin_representative_url(@representative)
  end
end
