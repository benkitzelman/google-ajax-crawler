require './spec/spec_helper'
describe GoogleAjaxCrawler::Page do
  context 'read' do
    let(:uri)     { URI.parse('http://www.test.com') }
    let(:options) { double(:options) }

    it 'should ask the driver to fetch content from a given uri' do
      options.stub_chain(:driver, :get_content).with(uri).and_return :wibble
      content = GoogleAjaxCrawler::Page.read(uri, options)
      content.should == :wibble
    end

  end
end