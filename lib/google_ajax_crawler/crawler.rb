
module GoogleAjaxCrawler
  class Crawler

    class << self
      def options
        configure if @options.nil?
        @options
      end

      def configure(&block)
        @options = Options.new(self, &block)
      end
    end

    def initialize(app = nil, &block)
      @app = app
      self.class.configure &block
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

    protected

    def is_search_engine?(request)
      request.params.include? options.requested_route_key
    end

    def as_uri_with_fragment(url)
      uri    = URI.parse(url)
      params = Rack::Utils.parse_query(uri.query).merge(search_engine: true)
      uri.fragment = "!#{params.delete options.requested_route_key}"
      uri.query    = Rack::Utils.build_query params
      uri
    end

    def serve_crawlable_content_for(request)
      puts ' -- GOOGLE Ajax Web Crawler Request --'
      html = GoogleAjaxCrawler::Page.read as_uri_with_fragment(request.url), options

      [200, options.response_headers, [html]]
    end

  end
end
