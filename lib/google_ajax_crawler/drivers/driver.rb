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
        if options.page_loaded_test.nil?
          default_page_loaded_test
        else
          options.page_loaded_test.call self
        end
      end

      def wait_until_page_is_fully_loaded
        Timeout::timeout(options.timeout) do
          begin
            while !is_page_loaded?
              sleep options.poll_interval
            end
          rescue
            #...squelch
            puts "Exception: #{$!}"
          end
        end
      end
    end
  end
end