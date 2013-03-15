require 'bundler/setup'
Bundler.require(:default)
require './lib/google_ajax_crawler'
require './spec/support/rack_app'

p 'conf', RackApp.configuration
run RackApp.app