require 'bundler/setup'
Bundler.require(:default)
require './lib/google_ajax_crawler'
require './spec/support/rack_app'

use GoogleAjaxCrawler::Crawler do |config|
  config.driver = GoogleAjaxCrawler::Drivers::CapybaraWebkit
  config.poll_interval    = 0.25
  config.page_loaded_test = lambda {|driver| driver.page.evaluate_script('document.getElementById("loading") == null') }
end

page_content = File.read('./spec/support/page.html')
run lambda {|env| [200, { 'Content-Type' => 'text/html' }, [page_content]] }