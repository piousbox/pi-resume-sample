Microsites2::Application.routes.draw do

  root :to => 'welcome#home'

  scope "/:locale", :constraints => { :locale => /en|ru|pt/ } do
    root :to => 'welcome#home'

    devise_for :users, :controllers => {
      :sessions => "users/sessions",
      :registrations => 'users/registrations'
    }

    get 'features', :to => 'sites#features', :as => :features
    get 'features/page/:features_page', :to => 'sites#features'
    get 'newsitems', :to => 'sites#newsitems', :as => :newsitems
    get 'newsitems/page/:newsitems_page', :to => 'sites#newsitems'
    get "sites/:domainname.html", :to => "sites#show", :as => :site, :constraints => { :domainname => /.*/, :format => /xml|html|json/ }

  
    # get 'photos/upload', :to => 'photos#upload', :as => :new_photo
    # post 'churn-photos', :to => 'photos#churn_photos', :as => :churn_photos
    match 'photos/driver-for/:gallery_id' => 'photos#driver', :as => :add_photos
    match 'photos/do_upload/:gallery_id/by/:username', :to => 'photos#do_upload', :as => :do_upload
    get 'photos/new_profile_photo', :to => 'photos#new', :defaults => { :is_profile => true }, :as => :new_profile_photo
    get 'photos/new-for-gallery/:gallery_id', :to => 'photos#new', :as => :new_photo_for_gallery
    resources :photos
  
    get '/users', :to => 'users#index', :as => :users
    get '/users/show/:username', :to => 'users#show', :as => :user
    put '/users/:id/update', :to => 'users#update', :as => :user_update
    get '/users/:username/resume', :to => 'users#show', :as => :user_resume
    get '/users/:username/resume/print', :to => 'users#show', :defaults => { :print => true }
    get '/users/:username/articles', :to => 'users#reports'
    get '/users/:username/articles/page/:reports_page', :to => 'users#reports'
    get '/users/:username/reports', :to => 'users#reports', :as => :user_reports
    get '/users/:username/reports/show/:name_seo', :to => 'users#report', :as => :user_report
    get '/users/:username/galleries', :to => 'users#galleries', :as => :user_galleries
    match '/users/scratchpad', :to => 'users#scratchpad', :as => :scratchpad
    get '/users/sign_in', :to => 'users#sign_in', :as => :sign_in
    get '/users/organizer', :to => 'users#organizer', :as => :organizer
    put '/users/show/:id', :to => 'users#update'
    get '/users/new_profile', :to => 'users#new_profile', :as => :new_user_profile
    get '/users/:username/profiles/:profile_id/edit', :to => 'users#edit_profile', :as => :edit_user_profile
    get '/users/gallery/:galleryname', :to => 'users#gallery', :as => :user_gallery
    get '/users/in-city/:cityname', :to => 'users#index', :as => :users_in_city
    post '/user_profiles', :to => 'users#create_profile'
    match '/users/search', :to => 'users#index', :as => :users_search
    get '/users/:username/github', :to => 'users#github_page', :as => :user_github
    get '/settings', :to => 'users#edit', :as => :settings

    get 'reports', :to => 'reports#index', :as => :report
    get 'reports/page/:reports_page', :to => 'reports#index'
    # get 'reports/view/:name_seo', :to => 'reports#show', :as => :report
    get 'reports/show/:name_seo', :to => 'reports#show', :as => :report
    get 'reports/:name_seo/venues', :to => 'reports#venues'
    put 'reports/:id', :to => 'reports#update', :as => :update_report
    get 'reports/new', :to => 'reports#new', :as => :new_report

    get 'galleries', :to => 'galleries#index', :as => :galleries
    get 'galleries/page/:galleries_page', :to => 'galleries#index'
    get 'galleries/new', :to => 'galleries#new', :as => :new_gallery
    get 'galleries/show/:galleryname/:photo_idx', :to => 'galleries#show', :as => :gallery, :constraints => { :photo_idx => /.*/ }
    get 'galleries/show/:galleryname', :to => 'galleries#show'
    get 'galleries/:style/:galleryname', :to => 'galleries#show', :as => :gallery_show_style, :constraints => { :style => /show_long|show_mini/ }
    get 'galleries/:id/edit', :to => 'galleries#edit', :as => :edit_gallery
    post 'galleries/:id', :to => 'galleries#update', :as => :update_gallery
    post 'galleries', :to => 'galleries#create'

    # resources :galleries
    # resources :reports

    # get 'v', :to => 'utils/utils#version', :as => :version

  end

  #
  # old legacy stuff
  #
  get 'google4b2e82b4dbbf505d', :to => 'utils/verification#one'
  get 'index.php/events/calendar/*everything' => redirect { |params, request| '/' }
  get 'index.php/events/view/*everything' => redirect { |params, request| '/' }
  get 'index.php/events/in/:cityname' => redirect { |params, request| "/cities/travel-to/#{params[:cityname]}" }
  get 'index.php' => redirect { |params, request| '/' }
  match 'venue_types/*everything' => redirect { |params, request| '/' }
  match 'venue_types' => redirect { |params, request| '/' }
  match 'dictionaryitems/*everything' => redirect { |params, request| '/' }
  match 'dictionaryitems' => redirect { |params, request| '/' }
  match 'helps/*everything' => redirect { |params, request| '/' }
  match 'helps' => redirect { |params, request| '/' }
  match 'events/*everything' => redirect { |params, request| '/' }
  match 'events' => redirect { |params, request| '/' }

  # add scope
  match '*other' => redirect { |params, request| "/en/#{params[:other]}" }

end
