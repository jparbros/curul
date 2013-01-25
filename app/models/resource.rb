class Resource < ActiveRecord::Base
  #
  # Scopes
  #
  if ENV['REINDEX'].blank?
    default_scope {where(site_id: Site.current_id)}
  end
  
end
