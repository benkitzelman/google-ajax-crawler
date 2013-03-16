module GoogleAjaxCrawler
  class << self
    def version
      "0.1.2"
    end
  end
end

require 'uri'
require 'google_ajax_crawler/crawler'
require 'google_ajax_crawler/options'
require 'google_ajax_crawler/page'
require 'google_ajax_crawler/drivers/driver'
require 'google_ajax_crawler/drivers/capybara_webkit'
