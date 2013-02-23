require 'spec_helper'
describe GoogleAjaxCrawlerProxy::GoogleAjaxCrawler do
	it 'should work' do
		s = OpenStruct.new(one:'one', two: 'two')
		s.one.should eq 'one'
	end
end
