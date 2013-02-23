#!/usr/bin/env ruby 
require "capybara"
require "capybara/dsl"
require "capybara-webkit"

module GoogleAjaxCrawlerProxy
  class PageProxy
    include Capybara::DSL

    JSON_HEADERS = {
      'Content-Type'  => 'text/html',
      'Cache-Control' => 'max-age=1, must-revalidate',
      'Keep-Alive'    => 'timeout=30, max=100'
    }

    def self.read(url)
      PageProxy.new.get_page_content(url)
    end

  	def get_page_content(url)
  	  config_capybara
      puts "requesting: #{url}"
      visit url
    	puts 'waiting for page load...'
    	wait_until_page_is_fully_loaded

      puts 'rendering proxied content'
      # puts html
      [200, JSON_HEADERS, html]
    end

    protected

    def config_capybara
      Capybara.run_server = false
      Capybara.current_driver = :webkit
      Capybara.app_host = "http://localhost:3000"
      Capybara.default_wait_time = 20
    end

    def stdout_to(output_file_path = '/dev/null')
      orig_stdout = $stdout
      $stdout = File.new(output_file_path, 'w')
      yield
      $stdout = orig_stdout
    end

    def wait_until_page_is_fully_loaded
      begin
        wait_until { page_is_loaded? }
      rescue
        #...squelch
        puts "Timeout: #{$!}"
      end
    end

    def page_is_loaded?
      visible_loading_masks.empty? && page.evaluate_script('$.active') == 0
    end
    
    def visible_loading_masks
      page.all('.loading, .spinner').select {|spinner| spinner.visible? }
    end

  end
end
