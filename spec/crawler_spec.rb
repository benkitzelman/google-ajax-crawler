require 'spec_helper'

describe GoogleAjaxCrawler::Crawler do
  before(:each) do
    GoogleAjaxCrawler::Crawler.configure do |config|
      config.page_loaded_test = lambda{ page.find('.loading', count: 0) }
    end
  end

  context 'configure' do
    it 'should configure' do
      GoogleAjaxCrawler::Crawler.configure do |config|
        config.timeout = 10
        config.driver  = MockDriver
      end
    
      GoogleAjaxCrawler::Crawler.options.timeout.should == 10
      GoogleAjaxCrawler::Crawler.options.driver.should be_a(MockDriver)
    end
  end
end
