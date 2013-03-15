require 'spec_helper'
describe GoogleAjaxCrawler::Options do
  context 'initialize' do
    let(:app) { Class.new }

    it 'should set default values' do
      options = GoogleAjaxCrawler::Options.new(app)
      options.driver.should be_a(GoogleAjaxCrawler::Drivers::CapybaraWebkit)
      options.timeout.should == 30
      options.requested_route_key.should == '_escaped_fragment_'
    end

    it 'should allow default overrides within block scope' do
      options = GoogleAjaxCrawler::Options.new(app) do |config|
        config.timeout = 20
        config.driver = MockDriver
      end

      options.timeout.should == 20
      options.driver.should be_a(MockDriver)
    end
  end
end
