class Site < ActiveRecord::Base
  #
  # Accessors
  #
  cattr_accessor :current_id
  
  def custom_layout?
    custom_layout
  end
end
