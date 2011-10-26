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
  gem.name = "scrapie"
  gem.homepage = "http://github.com/adrianpike/scrapie"
  gem.license = "MIT"
  gem.summary = %Q{Scrapie scrapes things for great justice.}
  gem.description = %Q{Scrapie is a tool that allows you to really simply and quickly fab up a class that translates CSS selectors into attributes, and lets you specify your own translations on query params. }
  gem.email = "adrian@pikeapps.com"
  gem.authors = ["Adrian Pike"]
  # dependencies defined in Gemfile
end
Jeweler::RubygemsDotOrgTasks.new


require 'rspec'
require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new('spec') do |t|
  t.pattern = 'spec/*_spec.rb'
#  t.rspec_opts = ["--backtrace"]
end

require 'rcov/rcovtask'
Rcov::RcovTask.new do |test|
  test.libs << 'test'
  test.pattern = 'test/**/test_*.rb'
  test.verbose = true
  test.rcov_opts << '--exclude "gems/*"'
end

task :default => :test

require 'rake/rdoctask'
Rake::RDocTask.new do |rdoc|
  version = File.exist?('VERSION') ? File.read('VERSION') : ""

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "scrapie #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end
