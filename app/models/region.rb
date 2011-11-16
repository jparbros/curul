class Region < ActiveRecord::Base
  
  #
  # Associations
  #
  has_many :provinces
  has_many :representatives
end
