require 'spec_helper'
describe 'reports', :type => :feature do
  before :each do
    Venue.all.each { |v| v.remove}
    @venue = FactoryGirl.create :venue
    Report.all.each { |r| r.remove }
    @report = FactoryGirl.create :report
    @report.venues << @venue && @report.save

    setup_sites
    @site = Site.all.first
    @site.domain = 'www.example.com'
    @site.save
  end

  it 'renders map on show if there are venues associated with the report' do
    visit "/reports/view/#{@report.name_seo}?layout=application_mini&lang=en"
    page.should have_css('#reports_show_canvas')
  end

  it 'renders no map if there are no venues' do
    ;
  end

end