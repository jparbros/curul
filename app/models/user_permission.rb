class UserPermission < ActiveRecord::Base
  attr_accessible :permission_id, :user_id
  
  belongs_to :user
  belongs_to :permission
end
