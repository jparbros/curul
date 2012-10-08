class Admin::BulkUpdateRepresentativesController < Admin::BaseController
  layout 'admin_full'
  
  def edit
    Representative.order('id asc').all
  end
  
  def update
    
  end
end
