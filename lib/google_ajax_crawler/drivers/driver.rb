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
        puts "requesting: #{uri}"
        visit uri.to_s

        wait_until_page_is_fully_loaded
        html
      end

      def is_page_loaded?
        if options.page_loaded_test.nil?
          default_page_loaded_test
        else
          options.page_loaded_test
        end
      end

      def wait_until_page_is_fully_loaded
        puts 'waiting for page load...'
        begin
          while !is_page_loaded?
            sleep 1
          end
        rescue
          #...squelch
          puts "Timeout: #{$!}"
        end
      end
    end
  end
end