
Microsites2::Application.routes.draw do

  devise_for :admin_users, ActiveAdmin::Devise.config
  devise_for :users, :controllers => { 
    :sessions => "users/sessions",
    :registrations => 'users/registrations'
  }
  
  ActiveAdmin.routes(self)

  root :to => 'welcome#home'
  
  match 'addressbookitems', :to => 'addressbookitems#index', :as => :search_addressbookitems
  match 'addressbookitems/search/:keyword', :to => 'addressbookitems#index', :as => :search_addressbookitems
  
  get 'blog', :to => 'blog#home', :as => :blog_root
  get 'blog/about', :to => 'blog#about', :as => :blog_about
  post 'blog/search', :to => 'blog#index', :as => :blog_search
  get 'blog/search/:keyword', :to => 'blog#index'
  get 'blog/index', :to => 'blog#index', :as => :blog_index
  get 'blog/view/:name_seo', :to => 'blog#show', :as => :blog_show
  get 'about', :to => 'welcome#about', :as => :about
  get 'privacy', :to => 'welcome#privacy', :as => :privacy
  
  resources :days
  post 'days/search', :to => 'days#search', :as => :search_days
  
  # get 'photos/upload', :to => 'photos#upload', :as => :new_photo
  # post 'churn-photos', :to => 'photos#churn_photos', :as => :churn_photos
  match 'photos/driver-for/:gallery_id' => 'photos#driver', :as => :add_photos
  match 'photos/do_upload/:gallery_id', :to => 'photos#do_upload', :as => :do_upload
  
  # post 'photos/move' => 'photos#move'
  post 'photos/:id/move', :to => 'manager/photos#move', :as => :move_photo
  resources :photos
  
  get 'tags/view/:name_seo', :to => 'tags#show'
  get 'tags/:id', :to => 'tags#show'

  get 'users/show/:username', :to => 'users#show', :as => :user
  get 'users/:username/resume', :to => 'users#resume', :as => :user_resume
  get 'users/:username/resume/print', :to => 'users#resume', :defaults => { :print => true }
  get 'users/:username/articles', :to => 'users#reports', :as => :user_reports
  get 'users/:username/galleries', :to => 'users#galleries', :as => :user_galleries
  match 'users/scratchpad', :to => 'users#scratchpad', :as => :scratchpad
  get 'users/account', :to => 'users#account', :as => :user_account
  get 'users/sign_in', :to => 'users#sign_in', :as => :sign_in
  get 'users/organizer', :to => 'users#organizer', :as => :organizer
  get 'users/account', :to => 'users#account', :as => :account
  get 'my/photos', :to => 'users#photos', :as => :my_photos
  get 'users/report/:name_seo', :to => 'users#report', :as => :user_report
  get 'users/gallery/:galleryname', :to => 'users#gallery', :as => :user_gallery
  get 'users/in-city/:cityname', :to => 'users#index', :as => :users_in_city
  
  get 'venues/show/:name_seo', :to => 'venues#show', :as => :venue
  get 'venues/in-city/:cityname', :to => 'venues#index', :as => :venues_in
  
  get 'cac', :to => 'cac#home', :as => :cac_root
  get 'cac/slider', :to => 'cac#slider', :as => :cac_slider
  get 'cac/contact', :to => 'cac#contact', :as => :cac_contact
  get 'cac/news', :to => 'cac#news', :as => :cac_news
  get 'cac/about', :to => 'cac#about', :as => :cac_about
  get 'cac/technology', :to => 'cac#technology', :as => :cac_technology
  get 'cac/portfolio', :to => 'cac#portfolio', :as => :cac_portfolio
  get 'cac/team', :to => 'cac#team', :as => :cac_team
  get 'cac/services', :to => 'cac#services', :as => :cac_services
  get 'cac/subscribe', :to => 'cac#subscribe', :as => :cac_subscribe
  get 'cac/privacy', :to => 'cac#privacy', :as => :cac_privacy
  get 'cac/news/:name_seo', :to => 'cac#show', :as => :cac_report
  get 'cities/travel-to/:cityname', :to => 'cities#profile', :as => :city_profile
  get 'cities/travel-to/:cityname/reports', :to => 'cities#reports', :as => :city_reports
  get 'cities/temp', :to => 'cities#temp'
  
  get 'ish', :to => 'welcome#ish_home', :as => :ish_root
  
  get 'travel/about', :to => 'travel#about', :as => :mobi_about
  get 'travel', :to => 'travel#home', :as => :travel_root
  
  
  get 'reports/view/:name_seo', :to => 'reports#show', :as => :report
  get 'reports/show/:name_seo', :to => 'reports#show'
  get 'reports/in-city/:cityname', :to => 'reports#index'
  post 'reports/search', :to => 'reports#search', :as => :search_reports
  post 'reports/search', :to => 'reports#search', :as => :my_search_reports, :defaults => { :my => true }
  get 'reports/search/:search_keyword', :to => 'reports#search'
  get 'my/reports', :to => 'reports#index', :as => :my_reports, :defaults => { :my => true }
  
  post 'galleries/search', :to => 'galleries#search', :as => :search_galleries
  get 'galleries/search/:search_keyword', :to => 'galleries#search'
  get 'galleries/view/:galleryname/:photos_page', :to => 'galleries#show'
  get 'galleries/view/:galleryname', :to => 'galleries#show', :defaults => { :photos_page => 1 }, :as => :gallery
  get 'galleries/in-city/:cityname', :to => 'galleries#index'
  get 'my/galleries', :to => 'galleries#index', :defaults => { :my => true }

  get 'videos/in-city/:cityname', :to => 'videos#index'
  get 'videos/view/:youtube_id', :to => 'videos#show'

  get 'set_locale', :to => 'welcome#set_locale', :as => :set_locale

  resources :reports
  resources :addressbookitems
  resources :galleries
  resources :subscriptions
  resources :messages
  resources :users
  resources :cities
  resources :events
  resources :venues
  resources :videos
  
  get 'my/timeline', :to => 'cities_users#index', :as => :my_timeline

  get 'sitemap', :to => 'utils/sitemaps#sitemap', :as => :sitemap

  get 'google4b2e82b4dbbf505d', :to => 'utils/verification#one'

  namespace :manager do
    root :to => 'welcome#homepage'
    
    get 'galleries/all_photos', :to => 'galleries#all_photos', :as => :all_photos
    get 'photos/no_gallery', :to => 'photos#no_gallery', :as => :photos_no_gallery
    
    resources :addressbookitems
    resources :articles
    resources :cities
    resources :galleries
    resources :photos
    resources :reports
    resources :sites
    resources :tags
    resources :venues
    resources :videos
    
  end
  
  delete 'manager/tags/destroy_tags_reports', :to => 'tags#testroy', 
    :as => :destroy_tags_reports
    
  match 'manager/cities/search', :to => 'cities#search', :as => :search_manager_cities
  match 'manager/cities/:id/change_profile_pic', :to => 'manager/cities#change_profile_pic', :as => :change_profile_pic_manager_city

  match 'manager/reports/search', :to => 'manager/reports#index', :as => :search_manager_reports
  post 'manager/reports/:id', :to => 'manager/reports#update', :as => :update_manager_report
  get 'manager/reports/:id', :to => 'manager/reports#show', :as => :show_manager_report
  match 'manager/reports/mark_features', :to => 'manager/reports#mark_features'

  match 'manager/reports/for-domain/sedux', :to => 'manager/reports#index',
    :as => :manager_reports_sedux, :defaults => { :this_domain => 'blog.sedux.net' }
  match 'manager/reports/for-domain/webdevzine', :to => 'manager/reports#index',
    :as => :manager_reports_webdevzine, :defaults => { :this_domain => 'blog.webdevzine.com' }

end
