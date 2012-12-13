class Authentication < ActiveRecord::Base
  attr_accessible :provider, :secret, :token, :uid, :user_id
end
