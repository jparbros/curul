class ContactForm
  include ActiveModel::Validations
  include ActiveModel::Conversion
  
  attr_accessor :nombre, :email, :comentario
  
  validates_presence_of :nombre, :email, :comentario
  
  def initialize(attributes = {})
    attributes.each do |name, value|
      send("#{name}=", value)
    end
  end

  def persisted?
    false
  end

end