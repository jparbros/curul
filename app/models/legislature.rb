class Legislature < ActiveRecord::Base

  #
  # Associations
  #
  has_many :comments
  has_many :initiatives
  has_many :representatives

  def self.active
    where(:active => true).last
  end
end
