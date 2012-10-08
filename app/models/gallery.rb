
class Gallery
  
  include Mongoid::Document
  
  belongs_to :tag
  
  field :name, :type => String
  field :subhead, :type => String
  field :descr, :type => String
  
  has_many :photos
  
end