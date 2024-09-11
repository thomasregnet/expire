require "bundler/gem_tasks"
require "cucumber/rake/task"
require "rspec/core/rake_task"

Cucumber::Rake::Task.new(:cucumber) do |task|
  task.cucumber_opts = ["--format=pretty"]
end

RSpec::Core::RakeTask.new(:spec)

task default: [:spec, :cucumber]
