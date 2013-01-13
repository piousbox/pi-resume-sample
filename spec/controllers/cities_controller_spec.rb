

require 'spec_helper'


describe CitiesController do
  
  before :each do
    City.all.each { |u| u.remove }
    @city = City.create :name => 'San Francisco', :cityname => 'San_Francisco'

    User.all.each { |f| f.remove }
    @user = FactoryGirl.create :user
    
    Report.all.each { |r| r.remove }
    @feature_pt_1 = FactoryGirl.create :feature_pt_1
    @feature_ru_1 = FactoryGirl.create :feature_ru_1

    @request.host = 'piousbox.com'
    
  end

  describe 'index' do
    
    it 'has reports' do
      get :index
      assigns(:feature_reports).should_not be nil
    end

    it 'can set locale' do
      get :index
      assigns(:locale).should_not be nil
    end

    it 'shows guide is there is a guide' do
      @city.guide = User.all.first
      @city.save
      u = User.all.first
      u.guide_city = @city
      u.save
      
      get :profile, :cityname => 'San_Francisco'
      response.should be_success
      assigns(:city).guide.should_not be nil
    end

    it 'displays only pt reports when locale is pt' do
      get :index, :locale => 'pt'
      assigns(:locale).should eql 'pt'
      feature_reports = assigns(:feature_reports)
      feature_reports.should_not be nil
      feature_reports.each do |r|
        r.lang.should eql 'pt'
      end

    end

    it 'displays only ru reports when locale is pt' do
      get :index, :locale => 'ru'
      assigns(:locale).should eql 'ru'
      feature_reports = assigns(:feature_reports)
      feature_reports.should_not be nil
      feature_reports.each do |r|
        r.lang.should eql 'ru'
      end

    end
    
  end

  describe 'profile' do
    it 'should have div galleries-index' do
      get :profile, :cityname => 'San_Francisco'
      response.should be_success

      city = assigns(:city)
      city.cityname.should eql 'San_Francisco'

      rs = assigns(:reports)
      (0..rs.length-1).each do |idx|
        rs[idx].created_at.should be >= rs[idx+1].created_at
      end
    end
    
  end

  describe 'todo' do
    it 'should have hierarcical layout for cities?' do
      false.should eql true, 'todo'
    end
    
  end
  
end
