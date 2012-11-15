class Site < ActiveRecord::Base
  #
  # Accessors
  #
  has_many :assets
  cattr_accessor :current_id

  def assets_js
    assets.by_type('js')
  end
  
  def assets_css
    assets.by_type('css')
  end
  
  def custom_layout?
    custom_layout
  end
end
