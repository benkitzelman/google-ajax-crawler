require './spec/spec_helper'
describe GoogleAjaxCrawler::Options do
  context 'initialize' do
    let(:app) { Class.new }

    it 'should set default values' do
      options = GoogleAjaxCrawler::Options.new(app)

      options.timeout.should              == 30
      options.requested_route_key.should  == '_escaped_fragment_'
      options.response_headers.should     == { 'Content-Type' => 'text/html' }
      options.poll_interval.should        == 0.5
      options.driver.should be_a(GoogleAjaxCrawler::Drivers::CapybaraWebkit)
      options.page_loaded_test.should be_nil
    end

    it 'should allow default overrides within block scope' do
      options = GoogleAjaxCrawler::Options.new(app) do |config|
        config.requested_route_key  = :some_other_key
        config.page_loaded_test     = :some_other_page_loaded_test
        config.poll_interval        = 7000
        config.response_headers     = :some_other_headers
        config.timeout              = 20
        config.driver               = MockDriver
      end

      options.requested_route_key.should  == :some_other_key
      options.page_loaded_test.should  == :some_other_page_loaded_test
      options.poll_interval.should        == 7000
      options.response_headers.should     == :some_other_headers
      options.timeout.should              == 20
      options.driver.should be_instance_of(MockDriver)
    end
  end
end
