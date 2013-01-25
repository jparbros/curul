class Commission < ActiveRecord::Base

  #
  # Associations
  #
  has_and_belongs_to_many :initiatives
  has_and_belongs_to_many :representatives
  #
  # Scope
  #
  if ENV['REINDEX'].blank?
    default_scope {where(site_id: Site.current_id)}
  end
end
