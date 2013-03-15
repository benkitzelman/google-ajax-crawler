require './spec/spec_helper'

describe 'CapybaraWebkit driver' do
  before(:all) do
    RackApp.configure_crawler do |config|
      config.driver = GoogleAjaxCrawler::Drivers::CapybaraWebkit
      config.poll_interval    = 0.25
      config.page_loaded_test = lambda {|driver| driver.page.evaluate_script('document.getElementById("loading") == null') }
    end

    RackApp.start
    Capybara.app = RackApp.app
    visit '/'
  end

  after(:all) do
    RackApp.stop
  end

  describe 'when a browser requests a client side route (i.e.: /#my_route)' do
    it 'should not serve a snapshot of the dom' do
      visit '/#test'
      page.find('#page_state').text.should_not == 'Javascript rendering complete for client-side route #test'
    end
  end

  describe 'when an ajax crawler requests a snapshot of a client side route' do
    it 'should serve a snapshot of the dom that includes js rendered components' do
      visit '/?_escaped_fragment_=test'
      page.find('#page_state').text.should == 'Javascript rendering complete for client-side route #test'
    end
  end
end