class Permission < ActiveRecord::Base
  attr_accessible :action, :subject_class
end
