class PoliticalParty < ActiveRecord::Base

  #
  # Associations
  #
  has_many :representatives

  #
  # Uploader
  #
  mount_uploader :logo, LogoUploader

  #
  # Scope
  #
  scope :political_parties, where('id NOT IN (8,9)')
  if ENV['REINDEX'].blank?
    default_scope {where(site_id: Site.current_id)}
  end
  
  

  def initials
    name.split(' ').collect {|word| word.first.downcase}.join('')
  end
end
