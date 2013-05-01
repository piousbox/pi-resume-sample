
require "open-uri"
require 'simple-rss'

class ReportsTasks
  
  def self.add_tasks
    # new reports with no tasks
    # get old report with same name_seo
    # get old tag for this report
    # save the new tag
    
  end
  
  def self.attached_photos_to_mongoid
    old_reports = SqlReport.find( :all,
      :conditions => [ 'photo_file_name is not null' ]
    )
    
    old_reports.each do |old_report|
      begin
        url = old_report.photo.url(:original)
        new_image = Photo.new
        new_image.photo = open(url)
        new_image.save
      
        new_report = Report.where( :name_seo => old_report.name_seo ).first
        new_report.photo = new_image
        new_report.save
      rescue; end
    end
    
  end
  
  def self.to_mongoid
    old_reports = SqlReport.find :all
    old_reports.each do |old|
      
      new = Report.new
      new.user = User.where( :username => 'piousbox' ).first
      new.name = old.name
      new.name_seo = old.name_seo
      new.descr = old.descr
      new.x = old.x
      new.y = old.y
      new.created_at = old.created_at
      new.updated_at = old.updated_at
      new.is_public = old.is_public
      new.is_feature = old.is_feature
      # new.is_trash = old.is_trash
      # new.is_done = old.is_done
      # new.city_id = old.city_id
      # new.cities_user_id = old.cities_user_id
      # new.address = old.address
      new.lang = old.lang
      
      # picture!
      
      new.save      
    end
  end

  def self.parse_reuters_technology_rss
    feed_addr = 'http://feeds.reuters.com/reuters/technologyNews'
    rss = SimpleRss.parse open(feed_addr)

  end

end
