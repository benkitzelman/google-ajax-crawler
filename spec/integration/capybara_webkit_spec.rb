require './spec/spec_helper'

describe 'CapybaraWebkit driver' do
  before(:all) do
    RackApp.configure do |config|
      config.driver = GoogleAjaxCrawler::Drivers::CapybaraWebkit
      config.poll_interval    = 0.25
      config.page_loaded_test = lambda {|driver| driver.page.evaluate_script('document.getElementById("loading") == null') }
    end

    RackApp.start
    Capybara.app = RackApp.app
  end

  after(:all) do
    RackApp.stop
  end

  describe 'when an ajax crawler requests a snapshot' do
    it 'should serve a snapshot of the dom after js rendering' do
      visit '/?_escaped_fragment_=test'
      page.should have_content('test')
    end
  end
end