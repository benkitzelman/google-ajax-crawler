module GoogleAjaxCrawler
  class Options
    attr_accessor :driver, :timeout, :requested_route_key, :page_loaded_test, :poll_interval, :response_headers

    def initialize(app, &block)
      @driver  = Drivers::CapybaraWebkit.new(self)
      @timeout = 30
      @requested_route_key  = '_escaped_fragment_'
      @response_headers     = { 'Content-Type' => 'text/html' }
      @poll_interval        = 0.5

      instance_exec(self, &block) unless block.nil?

      @app = app
    end

    def driver=(klass)
      @driver = klass.new(self)
    end

  end
end