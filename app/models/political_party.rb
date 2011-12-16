class PoliticalParty < ActiveRecord::Base
  
  #
  # Associations
  #
  has_many :representatives
  
  #
  # Uploader
  #
  mount_uploader :logo, LogoUploader
  
  def initials
    name.split(' ').collect {|word| word.first.downcase}.join('')
  end
end
