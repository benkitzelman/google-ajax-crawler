#
# to run:
# $ rackup examples/capybara_webkit.ru -p 3000
# open browser to http://localhost:3000/#!test
# or http://localhost:3000/backbone/#!test
# or http://localhost:3000/backbone/#!test
#
require 'bundler/setup'
require './lib/google_ajax_crawler'

use GoogleAjaxCrawler::Crawler do |config|
  config.driver        = GoogleAjaxCrawler::Drivers::CapybaraWebkit
  config.poll_interval = 0.25
  config.timeout       = 5

  #
  # for the demo - in each example (simple, backbone and angular) there is a page loaded function signaling
  # when the page has completed loading. If neither page_loaded_js or page_loaded_test has been configured, the crawler will default to
  # executing $.active == 0 to ensure no jquery ajax calls are pending
  #
  config.page_loaded_js = 'app.pageHasLoaded()'

  # alertnative server side test for the simple_javascript example:
  # config.page_loaded_test = -> driver { !driver.page.has_css?('#loading') }
end

#
# a sample page using #! url fragments to seed page state
#
app = -> env do 
  page_content = case env['PATH_INFO']
    when /\/backbone(\/)?/
      File.read('./spec/fixtures/backbone.html')
    when /\/angular(\/)?/
      File.read('./spec/fixtures/angular.html')
    else
      File.read('./spec/fixtures/simple_javascript.html')
  end

  [200, { 'Content-Type' => 'text/html' }, [page_content]]
end
run app