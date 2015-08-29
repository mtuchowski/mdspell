require 'rubocop/rake_task'

namespace :lint do
  RuboCop::RakeTask.new('style') do |task|
    task.options       = ['-c', 'config/rubocop.yml']
    task.fail_on_error = true
  end
end

namespace :docs do
  desc 'Check markdown files style'
  task :lint do
    system 'mdl . -gws config/mdl'
  end
end
