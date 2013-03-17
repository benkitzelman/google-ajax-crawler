ENV["RACK_ENV"] ||= "test"

require 'rubygems'
require 'bundler/setup'
require './lib/google_ajax_crawler'
require 'faraday'

here = File.dirname __FILE__
Dir["#{here}/support/*.rb"].each {|file| require file }

class MockDriver < GoogleAjaxCrawler::Drivers::Driver; end

