class Admin::BulkUpdateRepresentativesController < Admin::BaseController
  skip_authorization_check
  
  layout 'admin_full'
  
  def edit
    Representative.order('id asc').all
  end
end
