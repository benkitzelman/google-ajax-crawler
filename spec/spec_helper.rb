require 'rubygems'
require 'bundler/setup'
require 'rack'
require 'capybara/rspec'
require './lib/google_ajax_crawler'

here = File.dirname __FILE__
Dir["#{here}/support/*.rb"].each {|file| require file }

Capybara.run_server     = false
Capybara.current_driver = :selenium
Capybara.app_host = 'http://localhost:9999'

class MockDriver < GoogleAjaxCrawler::Drivers::Driver; end

RSpec.configure do |conf|
  conf.include Capybara::DSL
end
