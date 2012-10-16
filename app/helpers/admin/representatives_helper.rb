module Admin::RepresentativesHelper
  
  def comment_action_link_name(comment)
    comment.approved ? 'Desaprovar' : 'Aprovar'
  end
  
  def comment_action_link_url(comment)
    comment.approved ? admin_representative_comment_unapprove_path(comment.commentable, comment) : admin_representative_comment_approve_path(comment.commentable, comment)
  end
  
  def comment_action_link_class(comment)
    comment.approved ? 'btn-danger' : 'btn-primary'
  end
end
