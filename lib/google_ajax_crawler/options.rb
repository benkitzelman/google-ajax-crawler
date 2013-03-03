module GoogleAjaxCrawler
  class Options
    attr_accessor :driver

    def initialize(app, &block)
      instance_eval &block
      @app = app
    end

    def driver
      @driver ||= Driver::CapybaraWebkit.new
    end
  end
end