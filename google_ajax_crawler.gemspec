$LOAD_PATH << './lib'
require 'google_ajax_crawler'
Gem::Specification.new do |s|
  s.name        = 'google_ajax_crawler'
  s.version     = GoogleAjaxCrawler.version
  s.summary     = 'Rack Middleware adhering to the Google Ajax Crawling Scheme ensuring your JS rendered page states (i.e. BackboneJS routes) can be crawled and indexed by search engines.'
  s.description = 'Rack Middleware adhering to the Google Ajax Crawling Scheme, using a headless browser to render JS heavy pages and serve a dom snapshot of the rendered state to a requesting search engine.'
  s.authors     = ['Ben Kitzelman']
  s.email       = ['benkitzelman@gmail.com']
  s.homepage    = 'http://github.com/benkitzelman/google-ajax-crawler'
  s.files       = `git ls-files`.strip.split("\n")
  s.executables = []

  s.add_dependency 'capybara-webkit', '>= 0.10.0'
  s.add_dependency 'rack'
end