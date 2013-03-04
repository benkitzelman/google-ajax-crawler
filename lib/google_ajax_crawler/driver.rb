require "capybara"
require "capybara/dsl"
require "capybara-webkit"

module GoogleAjaxCrawler
  class Driver
    attr_reader :options

    def initialize(options)
      @options = options
    end

    def get_content(uri)
      raise "Driver Not Specified"
    end

    class CapybaraWebkit < Driver
      include Capybara::DSL

      def get_content(uri)
        config_capybara_for uri

        puts "requesting: #{uri}"
        visit uri.to_s

        wait_until_page_is_fully_loaded
        html
      end

      def config_capybara_for(uri)
        Capybara.run_server     = false
        Capybara.current_driver = :webkit
        Capybara.app_host       = "#{uri.scheme}://#{uri.host}:#{uri.port}"
        Capybara.default_wait_time = options.timeout
      end

      protected

      def wait_until_page_is_fully_loaded
        puts 'waiting for page load...'
        begin
          visible_loading_masks.empty? && page.evaluate_script('$.active') == 0
        rescue
          #...squelch
          puts "Timeout: #{$!}"
        end
      end

      def visible_loading_masks
        page.all('.loading, .spinner').select {|spinner| spinner.visible? }
      end
    end
  end
end