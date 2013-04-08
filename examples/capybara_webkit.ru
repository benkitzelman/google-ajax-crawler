#
# to run:
# $ rackup examples/capybara_webkit.ru -p 3000
# open browser to http://localhost:3000/#!test
#
require 'bundler/setup'
require './lib/google_ajax_crawler'

use GoogleAjaxCrawler::Crawler do |config|
  config.driver = GoogleAjaxCrawler::Drivers::CapybaraWebkit
  config.poll_interval = 0.25

  #
  # for the demo - the page is considered loaded when the loading mask has been removed from the DOM
  # this could evaluate something like $.active == 0 to ensure no jquery ajax calls are pending
  #
  config.page_loaded_test = lambda {|driver| driver.page.evaluate_script('document.getElementById("loading") == null') }
end

#
# a sample page using #! url fragments to seed page state
#
page_content = File.read('./spec/support/page.html')
run lambda {|env| [200, { 'Content-Type' => 'text/html' }, [page_content]] }
