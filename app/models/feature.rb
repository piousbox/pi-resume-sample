
class Feature  
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name, :type => String
  field :subhead, :type => String
  field :link_path, :type => String

  has_one :photo
  
  #  belongs_to :photo
  #  belongs_to :report
  #  belongs_to :gallery

  embedded_in :venue
  embedded_in :site

end

# name: User Piousbox
#  image_path: /assets/ppf.gif
#  subhead: If you are looking for user `piousbox`, the software developer, this is his profile.
#  link_path: /users/show/piousbox