class ApplicationController < ActionController::Base
  protect_from_forgery
  
  before_filter :scope_current_site, :authenticate_user!
  
  check_authorization :unless => :devise_controller?
  
  def current_site
    @current_site ||= Site.find_by_subdomain! subdomain
  end  
  helper_method :current_site
  
  def scope_current_site
    Site.current_id = current_site.try(:id) || nil
  end
  
  def subdomain
    request.subdomain
  end
end
