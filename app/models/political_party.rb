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

  def initials
    name.split(' ').collect {|word| word.first.downcase}.join('')
  end
end
