

require 'reports_tasks'

namespace :reports do
  
  desc "migrate some features to mongoid"
  task :some_features => :environment do
    ReportsTasks.some_features
    
  end
  
  desc 'to mongoid'
  task :to_mongoid => :environment do
    ReportsTasks.to_mongoid
  end
  
end
