require 'rubocop/rake_task'
require 'reek/rake/task'

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
