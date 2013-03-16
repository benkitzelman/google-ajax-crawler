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

  	def get_page_content(uri = URI.parse("http://localhost"))
      options.driver.get_content uri
    end
  end
end
