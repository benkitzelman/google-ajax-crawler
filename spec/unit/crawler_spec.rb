require './spec/spec_helper'

describe GoogleAjaxCrawler::Crawler do
  shared_examples 'a crawler configurer' do |method, *args|
    it 'and facilitate the setting of crawler options' do
      GoogleAjaxCrawler::Crawler.send(method, *args) do |config|
        config.timeout = 10
        config.driver  = MockDriver
      end
    
      GoogleAjaxCrawler::Crawler.options.timeout.should == 10
      GoogleAjaxCrawler::Crawler.options.driver.should be_instance_of(MockDriver)
    end
  end

  context 'configure' do
    it_should_behave_like 'a crawler configurer', :configure
  end    

  context 'initialize' do
    it_should_behave_like 'a crawler configurer', :new, nil
  end

  context 'call' do
    let(:app) { double(:app) }
    let(:request) { {
      'HTTP_METHOD'     => 'GET',
      'HTTP_HOST'       => 'test.com',
      'PATH_INFO'       => '/test',
      'QUERY_STRING'    => 'some_key=some_val',
      'rack.url_scheme' => 'http',
      "rack.input"      => :blah
    } }
    let(:search_engine_request) { request.merge('QUERY_STRING' => '_escaped_fragment_=test') }
    let(:crawler) { GoogleAjaxCrawler::Crawler.new app }
    
    it 'should delegate non snapshot requests to the configured app' do
      app.should_receive(:call).with request
      crawler.call request
    end

    it 'should generate a rendered snapshot on search engine requests' do
      GoogleAjaxCrawler::Page.stub(:read).and_return :wibble
      response = crawler.call search_engine_request
      response.should == [200, GoogleAjaxCrawler::Crawler.options.response_headers, [:wibble]]
    end
  end
end
