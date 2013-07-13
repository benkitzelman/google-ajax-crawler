require './spec/spec_helper'

describe GoogleAjaxCrawler::Drivers::Driver do
  let(:options) { GoogleAjaxCrawler::Options.new(nil) { |o| o.timeout = 0.01 } }
  let(:driver)  { GoogleAjaxCrawler::Drivers::Driver.new(options) }

  describe '#mandatory overrides' do
    shared_examples 'an enforced override method' do |method, *args|
      it 'should throw an exception if not overridden' do
        expect { driver.send(method, *args) }.to raise_error(RuntimeError, "Driver Not Specified")
      end
    end

    it_should_behave_like 'an enforced override method', :visit, 'http://test.com'
    it_should_behave_like 'an enforced override method', :evaluate_script, 'myApp.isPageLoaded()'
    it_should_behave_like 'an enforced override method', :default_page_loaded_test
    it_should_behave_like 'an enforced override method', :html
  end

  describe '#is_page_loaded?' do

    describe 'when page_loaded_test optioned' do
      it 'should be called' do
        driver.options.page_loaded_test = double
        driver.options.page_loaded_test.should_receive(:call).with(driver)
        driver.is_page_loaded?
      end
    end

    describe 'when page_loaded_js optioned' do
      it 'should call evaluate_script with the page_loaded_js' do
        driver.options.page_loaded_js = 'MyApp.isPageLoaded()'
        driver.stub :evaluate_script
        driver.should_receive(:evaluate_script).with('MyApp.isPageLoaded()').once
        driver.is_page_loaded?
      end
    end

    describe 'when no loaded tests optioned' do
      it 'should execute the default_page_loaded_test' do
        driver.options.page_loaded_test = driver.options.page_loaded_js = nil
        driver.stub :default_page_loaded_test
        driver.should_receive(:default_page_loaded_test).once
        driver.is_page_loaded?
      end
    end
  end

  describe '#wait_until_page_is_fully_loaded' do
    before do
      driver.options.page_loaded_test = double
      driver.options.page_loaded_test.should_receive(:call).with(driver)
    end

    it 'should raise a Timeout Exception when timeout limit reached' do
      expect do
        driver.wait_until_page_is_fully_loaded
      end.to raise_error(Timeout::Error)
    end
  end
end
