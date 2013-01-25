class Legislature < ActiveRecord::Base

  #
  # Associations
  #
  has_many :comments
  has_many :initiatives
  has_many :representatives

  #
  # Scope
  #
  if ENV['REINDEX'].blank?
    default_scope {where(site_id: Site.current_id)}
  end
  
  
  def self.active
    where(:active => true).last
  end
end
