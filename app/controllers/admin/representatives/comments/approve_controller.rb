class Admin::Representatives::Comments::ApproveController < Admin::BaseController
  def create
    @representative = Representative.find params[:representative_id]
    @comment = @representative.comments.find params[:comment_id]
    @comment.approve!
    redirect_to admin_representative_url(@representative)
  end
end
