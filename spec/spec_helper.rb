require 'rubygems'
require 'bundler/setup'
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib', 'google_ajax_crawler'))
$LOAD_PATH.unshift(File.dirname(__FILE__))

require 'crawler'
require 'page'
require 'options'
require 'driver'

module TestRackApp
  def self.run
    app = Rack::Builder.new do
      map "/" do
        [200, {}, 'ok']
      end
    end

    Rack::Server.start(:app => app, :Port => 9999)
    puts 'Started... http://localhost:9999'
  end
end

# before(:all) do
#   TestRackApp.run
# end