require 'spec_helper'
describe GoogleAjaxCrawlerProxy::PageProxy do
	it 'should read page content' do
		PageProxy
		PageProxy.read 'http://test.url'
	end
end
