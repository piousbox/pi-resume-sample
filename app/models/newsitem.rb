

class Newsitem

  include Mongoid::Document
  include Mongoid::Timestamps
  
  embedded_in :city
  embedded_in :user

  belongs_to :photo
  belongs_to :report

  field 'descr', :type => String
  field 'username', :type => String
  
end