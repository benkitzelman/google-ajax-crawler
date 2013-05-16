require 'rack'

class RackApp

  def app
    page_content = File.read('./spec/fixtures/simple_javascript.html')
    Rack::Builder.new do

      use GoogleAjaxCrawler::Crawler do |c|
        RackApp.crawler_configuration.call(c)
      end

      map '/' do
        run lambda {|env| [200, { 'Content-Type' => 'text/html' }, [page_content]] }
      end
    end
  end

  class << self
    attr_reader :crawler_configuration

    def app
      (@app ||= RackApp.new).app
    end

    def configure_crawler(&block)
      @crawler_configuration = block
    end

    def port
      9999
    end

    def start
      setup!
      pid = Process.fork
      if pid.nil?
        Rack::Server.start(:app => app, :Port => port)
      else
        File.open(pidfile, 'w') { |f| f.write pid }
        trap("SIGINT") { stop }
        Process.detach pid
        sleep 1
      end
    end

    def stop
      return unless running?

      Process.kill 9, pid
      File.delete pidfile
      puts "[Stopped rack app...]"
    end

    def setup!
      FileUtils.mkpath(File.dirname(pidfile))
      FileUtils.mkpath(File.dirname(logfile))
    end

    def pidfile
      "tmp/server.pid"
    end

    def logfile
      "tmp/server.log"
    end

    def pid
      running? ? File.read(pidfile).to_i : 0
    end

    def running?
      File.exists?(pidfile)
    end

    def restart
      stop if running?
      start
    end

    def log_to_file
      log = File.new RackApp.logfile, "a"
      STDOUT.reopen log
      STDERR.reopen log
    end
  end
end
