class Admin::BaseController < ApplicationController
  before_filter :authenticate_user!
  
  check_authorization :unless => :devise_controller?
  
  layout 'admin'
end
