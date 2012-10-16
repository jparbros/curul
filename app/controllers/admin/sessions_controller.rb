class Admin::SessionsController < Devise::SessionsController
  layout 'admin_login'
  
  def create
    resource = warden.authenticate!(:scope => resource_name, :recall => "#{controller_path}#new")
    puts resource
    if resource.admin?
      sign_in(resource_name, resource)
      respond_with resource, :location => after_sign_in_path_for(resource)
    else
      render :new
    end
  end
end
