class Province < ActiveRecord::Base
  
  #
  # Associations
  #
  belongs_to :region
  has_many :representatives
end
