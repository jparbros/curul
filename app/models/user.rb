class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :admin, :permission_ids
  # attr_accessible :title, :body
  
  has_many :user_permissions
  has_many :permissions, through: :user_permissions
  has_many :authentications
  
  #
  # Scope
  #
  
  def apply_authorization
    if new_record?
      _password = SecureRandom.hex(5)
      self.password = _password
      self.password_confirmation = _password
      self.email = "#{_password}#{TEMPORAL_EMAIL}" if email.blank?
    end
  end
  
  def apply_omniauth(omniauth)
    case omniauth['provider']
    when 'facebook'
      self.apply_facebook(omniauth)
    when 'twitter'
      self.apply_twitter(omniauth)
    end
    authentications.build(hash_from_omniauth(omniauth))
    save!
  end
  
  def missing_complete_register?
    email.nil? || email.match(/#{User::TEMPORAL_EMAIL}/)
  end
  

  protected

  def apply_facebook(omniauth)
    if omniauth['extra']['raw_info'].present?
      self.email = omniauth['extra']['raw_info']['email'] if omniauth['extra']['raw_info']['email'].present? && email.blank?
      self.first_name = omniauth['extra']['raw_info']['first_name'] if omniauth['extra']['raw_info']['first_name'].present? && first_name.blank?
      self.last_name = omniauth['extra']['raw_info']['last_name'] if omniauth['extra']['raw_info']['last_name'].present? && last_name.blank?
      self.profile.username = omniauth['extra']['raw_info']['username'] if omniauth['extra']['raw_info']['username'].present? && profile.username.blank?
    end
  end

  def apply_twitter(omniauth)
    if omniauth['extra']['raw_info'].present?
      self.email = omniauth['extra']['raw_info']['email'] if omniauth['extra']['raw_info']['email'].present? && email.blank?
      if omniauth['extra']['raw_info']['name'].present?
        name = extract_name(omniauth['extra']['raw_info']['name'])
        self.first_name = name[0] if first_name.blank?
        self.last_name = name[1] if last_name.blank?
      end
      self.profile.username = omniauth['extra']['raw_info']['screen_name'] if omniauth['extra']['raw_info']['screen_name'].present? && profile.username.blank?
    end
  end

  def hash_from_omniauth(omniauth)
    {
      :provider => omniauth['provider'],
      :uid => omniauth['uid'],
      :token => (omniauth['credentials']['token'] rescue nil),
      :secret => (omniauth['credentials']['secret'] rescue nil)
    }
  end

end
