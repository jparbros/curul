class Asset < ActiveRecord::Base
   attr_accessible :name, :site_id, :type_a
   belongs_to :site
   scope :by_type, lambda{|type| where("type_a = ?", type)}
   mount_uploader :name, AssetUploader
   
   liquid_methods :name_url
   
end
