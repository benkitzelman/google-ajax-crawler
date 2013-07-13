module GoogleAjaxCrawler
  class << self
    def env
      (ENV['RACK_ENV'] || 'development').to_sym
    end

    def version
      "0.2.0"
    end
  end
end

here = File.dirname(__FILE__)
require 'uri'
require "#{here}/google_ajax_crawler/crawler"
require "#{here}/google_ajax_crawler/options"
require "#{here}/google_ajax_crawler/page"
require "#{here}/google_ajax_crawler/drivers/driver"
require "#{here}/google_ajax_crawler/drivers/capybara_webkit"
