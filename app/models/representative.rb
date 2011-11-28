class Representative < ActiveRecord::Base
  
  #
  # Associatons
  #
  belongs_to :region
  belongs_to :province
  belongs_to :political_party
  has_and_belongs_to_many :commissions
  has_many :initiatives
  has_many :comments, :as => :commentable, :dependent => :destroy
  
  #
  # Uploader
  #
  mount_uploader :avatar, AvatarUploader
  
  #
  # scopes
  #
  scope :by_region, lambda {|region_id| where(:region_id => region_id)}
end
