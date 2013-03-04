module GoogleAjaxCrawler
  class Options
    attr_accessor :driver, :timeout, :requested_route_key

    def initialize(app, &block)
      @driver  = Driver::CapybaraWebkit.new(self)
      @timeout = 30
      @requested_route_key = '_escaped_fragment_'

      instance_eval &block

      @app = app
    end

    def driver=(klass)
      @driver = klass.new(self)
    end
  end
end