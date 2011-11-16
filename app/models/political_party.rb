class PoliticalParty < ActiveRecord::Base
  
  #
  # Associations
  #
  has_many :representatives
  
  #
  # Uploader
  #
  mount_uploader :logo, LogoUploader
end
