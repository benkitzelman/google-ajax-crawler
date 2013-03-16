require 'rack/utils'
require 'uri'

base_path = './lib/google_ajax_crawler'

require "#{base_path}/drivers/driver"
[base_path, "#{base_path}/drivers"].each do |folder|
  Dir["#{folder}/*.rb"].each {|file| require file }
end

module GoogleAjaxCrawler
  def self.version
    "0.1.0"
  end
end