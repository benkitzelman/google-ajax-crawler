
module GoogleAjaxCrawler
  class Crawler

    class << self
      def options
        return @options unless @options.nil?
        raise "The Crawler must be configured before crawling a URL (Crawler.configure)"
      end

      def configure(&block)
        @options = Options.new(self, &block)
      end
    end

    def initialize(app)
      @app = app
    end

    def options
      self.class.options
    end

    def call(env)
      request = Rack::Request.new(env)
      if is_search_engine?(request)
        serve_crawlable_content_for request
      else
        @app.call(env)
      end
    end

    def crawl(url)
      GoogleAjaxCrawler::Page.read browser_uri_for(url), options
    end

    protected

    def is_search_engine?(request)
      request.params.include? options.requested_route_key
    end

    def browser_uri_for(url)
      uri    = URI.parse(url)
      params = Rack::Utils.parse_query(uri.query).merge(search_engine: true)
      uri.fragment = params.delete options.requested_route_key
      uri.query    = Rack::Utils.build_query params
      uri
    end

    def serve_crawlable_content_for(request)
      puts ' -- GOOGLE Ajax Web Crawler Request --'
      html = GoogleAjaxCrawler::Page.read browser_uri_for(request.url), options

      puts 'rendering proxied content'
      [200, json_headers, html]
    end
  end
end
