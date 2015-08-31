require 'rubocop/rake_task'
require 'reek/rake/task'
require 'rspec/core/rake_task'

namespace :lint do
  RuboCop::RakeTask.new('style') do |task|
    task.options       = ['-c', 'config/rubocop.yml']
    task.fail_on_error = true
  end

  Reek::Rake::Task.new('maintainability') do |task|
    task.config_file   = 'config/reek.yml'
    task.source_files  = 'lib/**/*.rb'
    task.fail_on_error = true
  end
end

namespace :docs do
  desc 'Check markdown files style'
  task :lint do
    system 'mdl . -gws config/mdl'
  end
end

RSpec::Core::RakeTask.new('spec') do |task|
  task.rspec_opts    = '--options config/rspec'
  task.fail_on_error = true
end

desc 'delete generated files'
task :clobber do
  sh 'rm -rf .yardoc'
  sh 'rm -rf doc'
end

desc 'generate rdoc'
task :rdoc do
  sh 'yardoc'
end
