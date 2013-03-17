$:.unshift File.join(File.dirname(__FILE__), 'lib')

require 'bundler/setup'
require 'rspec/core/rake_task'

desc "Run specifications"
RSpec::Core::RakeTask.new(:spec)

task :default => :spec
