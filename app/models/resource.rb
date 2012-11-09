class Resource < ActiveRecord::Base
  #
  # Scopes
  #
  default_scope {where(site_id: Site.current_id)}
end
