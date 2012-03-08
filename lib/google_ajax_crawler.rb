require 'page_proxy'
module GoogleAjaxCrawlerProxy
  class GoogleAjaxCrawler
    HASHBANG_KEY = '_escaped_fragment_'
    URL_PREFIX = '/?search-engine=true#!'

    def initialize(app)
      @app = app
    end

    def call(env)
      request = Rack::Request.new(env)
      if request.params.include? HASHBANG_KEY
        serve_crawlable_content_for request
      else
        @app.call(env)
      end
    end

    protected
    def serve_crawlable_content_for(request)
      puts ' -- GOOGLE Ajax Web Crawler Request --'
      hashbanged_route = request.params.delete HASHBANG_KEY
      GoogleAjaxCrawlerProxy::PageProxy.read "#{URL_PREFIX}#{hashbanged_route}"
    end
  end
end
