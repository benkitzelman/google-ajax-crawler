require "capybara"
require "capybara/dsl"
require "capybara-webkit"

module GoogleAjaxCrawler
  class Driver

    def get_content(uri)
      raise "Driver Not Specified"
    end

    class CapybaraWebkit < Driver
      include Capybara::DSL

      def get_content(uri)
        config_capybara_for uri
        puts "requesting: #{uri}"
        visit uri.to_s
        puts 'waiting for page load...'
        wait_until_page_is_fully_loaded
      end

      def config_capybara_for(uri)
        puts "#{uri.scheme}://#{uri.host}:#{uri.port}"
        Capybara.run_server     = false
        Capybara.current_driver = :webkit
        Capybara.app_host       = "#{uri.scheme}://#{uri.host}:#{uri.port}"
        Capybara.default_wait_time = 20
      end

      protected

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
end