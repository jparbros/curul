# encoding: utf-8
class Representative < ActiveRecord::Base

  #
  # Associatons
  #
  belongs_to :region
  belongs_to :province
  belongs_to :political_party
  belongs_to :legislature
  has_and_belongs_to_many :commissions
  has_many :initiatives
  has_many :comments, :as => :commentable, :dependent => :destroy

  #
  # Accessor
  #
  attr_reader :commission_tokens

  #
  # Uploader
  #
  mount_uploader :avatar, AvatarUploader

  #
  # scopes
  #
  scope :by_region, lambda {|region_id| where(:region_id => region_id)}
  scope :by_commission, lambda {|commission_id| joins(:commissions).where('commissions_representatives.commission_id = ?', commission_id)}
  scope :most_commented, order('comments_count DESC')
  scope :political_parties, where('political_party_id NOT IN (8,9)')
  scope :actual_legislature, where(:legislature_id => (Legislature.active ? Legislature.active.id : nil))
  default_scope {where(site_id: Site.current_id)}

  #
  # Delegates
  #
  delegate :name, to: :region, prefix: true, allow_nil: true
  delegate :name, to: :political_party, prefix: true, allow_nil: true
  
  #
  # Constants
  #
  ELECTION_TYPE = [['Mayoría Relativa','Mayoría Relativa'],['Representación proporcional','Representación proporcional']]
  POSITION = [['Diputado','Diputado'],['Senado','Senado'],['Ejecutivo','Ejecutivo']]
  
  #
  # Extensions
  #
  include SolrSearch::Representatives
  
  
  def name
    "#{first_name} #{last_name}"
  end

  def commission_tokens=(ids)
    self.commission_ids = ids.split(',')
  end

  def photo(size = nil)
    return self.avatar.url(size) unless self.avatar.url.nil? || self.avatar.url.include?('txt')
    unless size
      'front/missing.png'
    else
      'front/thumb_missing.png'
    end
  end

  # def as_json(options)
  #   options.merge!({include: [:region, :political_party], methods: [:photo]}) if options
  #   super(options)
  # end
  
  def to_json_for_bulk_update
    #.map {||}
  end
end
