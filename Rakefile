$:.unshift File.join(File.dirname(__FILE__), 'lib')

require 'bundler/setup'
require 'rspec/core/rake_task'

desc "Run specifications"
RSpec::Core::RakeTask.new(:spec)

task :ci do
  puts 'running tests on CI Server....'
  system("export DISPLAY=:99.0 && bundle exec rake spec")
  raise "rake spec failed!" unless $?.exitstatus == 0  
end

task :default => :ci
