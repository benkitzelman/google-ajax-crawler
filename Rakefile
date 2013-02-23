# encoding: utf-8

require 'rubygems'
require 'bundler'
begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end
require 'rake'

require 'jeweler'
Jeweler::Tasks.new do |gem|
  # gem is a Gem::Specification... see http://docs.rubygems.org/read/chapter/20 for more options
  gem.name = "google-ajax-crawler"
  gem.homepage = "http://github.com/benkitzelman/google-ajax-crawler"
  gem.license = "MIT"
  gem.summary = %Q{An implementation of the Google AJAX Crawling Scheme for Rack apps}
  gem.description = %Q{An implementation of the Google AJAX Crawling Scheme for Rack apps}
  gem.email = "benkitzelman@gmail.com"
  gem.authors = ["Ben Kitzelman"]
  # dependencies defined in Gemfile
  gem.add_dependency 'capybara-webkit', '>= 0.10.0'
end
Jeweler::RubygemsDotOrgTasks.new

task :default => :spec

require 'rdoc/task'
Rake::RDocTask.new do |rdoc|
  version = File.exist?('VERSION') ? File.read('VERSION') : ""

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "google-ajax-crawler #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end
