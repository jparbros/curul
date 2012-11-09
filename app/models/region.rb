class Region < ActiveRecord::Base
  
  #
  # Associations
  #
  has_many :provinces
  has_many :representatives
  #
  # Scopes
  #
  default_scope {where(site_id: Site.current_id)}
end
