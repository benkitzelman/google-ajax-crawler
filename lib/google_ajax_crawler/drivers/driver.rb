require 'timeout'
module GoogleAjaxCrawler
  module Drivers
    class Driver
      attr_reader :options

      def initialize(options)
        @options = options
      end

      def visit(url)
        raise "Driver Not Specified"
      end

      def default_page_loaded_test
        raise "Driver Not Specified"
      end

      def html
        raise "Driver Not Specified"
      end

      def get_content(uri)
        begin
          puts "::requesting: #{uri}"
          visit uri.to_s
          wait_until_page_is_fully_loaded
        rescue Timeout::Error
          puts  "-- Page Rendering Timed out: --\n"\
                "Either your page_loaded_test didn't successfully detect when your page had loaded, \n"\
                "or your page took longer than #{options.timeout} seconds to load \n"\
                "-- Returning page snapshot in its present state --"
        end
        html
      end

      def is_page_loaded?
        return default_page_loaded_test if options.page_loaded_test.nil?
        options.page_loaded_test.call self
      end

      def wait_until_page_is_fully_loaded
        Timeout::timeout(options.timeout) do
          begin
            sleep(options.poll_interval) while !is_page_loaded?
          rescue
            #...squelch
            puts "Exception: #{$!}"
          end
        end
      end
    end
  end
end