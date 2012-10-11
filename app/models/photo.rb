

class Photo
  
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Paperclip
  
  belongs_to :gallery
  
  has_mongoid_attached_file :photo, 
    :styles => {
    :mini => '20x20#',
    :thumb=> "100x100#",
    :small  => "400x400>",
    :small_square => "400x400#",
    :large => '950x950>',
    :large_square => '950x950#'
  },
    :storage => :s3,
    :s3_credentials => S3_CREDENTIALS,
    :path => "photos2/:style/:id/:filename"

end


