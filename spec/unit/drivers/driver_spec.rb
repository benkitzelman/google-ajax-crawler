require './spec/spec_helper'

describe GoogleAjaxCrawler::Drivers::Driver do
  let(:options) do 
    GoogleAjaxCrawler::Options.new(nil) do |o|
      o.timeout = 0.05
      o.page_loaded_test = lambda {|d| false }
    end
  end

  describe '#wait_until_page_is_fully_loaded' do
    it 'should raise a Timeout Exception when timeout limit reached' do
      expect do
        driver = GoogleAjaxCrawler::Drivers::Driver.new(options)
        driver.wait_until_page_is_fully_loaded
      end.to raise_error(Timeout::Error)
    end
  end
end
