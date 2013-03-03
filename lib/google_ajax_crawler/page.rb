
module GoogleAjaxCrawler
  class Page
    attr_reader :options

    def self.read(uri, options)
      page = Page.new(options)
      page.get_page_content(uri)
    end
  
    def initialize(options)
      @options = options
    end

    def json_headers
      {
        'Content-Type'  => 'text/html',
        'Cache-Control' => 'max-age=1, must-revalidate',
        'Keep-Alive'    => 'timeout=30, max=100'
      }
    end

  	def get_page_content(uri = URI.parse("http://localhost:3000"))
      html = options.driver.get_content uri

      puts 'rendering proxied content'
      [200, json_headers, html]
    end

    protected

    def stdout_to(output_file_path = '/dev/null')
      orig_stdout = $stdout
      $stdout = File.new(output_file_path, 'w')
      yield
      $stdout = orig_stdout
    end
  end
end
