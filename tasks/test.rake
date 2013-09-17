require "rspec/core/rake_task"
namespace :test do

  desc "Run unit tests"
  RSpec::Core::RakeTask.new(:unit) do |t|
    t.pattern = "spec/unit/**/test_*.rb"
    t.fail_on_error = true
    t.failure_message = nil
    t.verbose = true
    t.rspec_path = "rspec"
    t.rspec_opts = ["--color", "--backtrace"]
  end

  desc "Run unit tests"
  RSpec::Core::RakeTask.new(:integration) do |t|
    t.pattern = "spec/integration/**/test_*.rb"
    t.fail_on_error = true
    t.failure_message = nil
    t.verbose = true
    t.rspec_path = "rspec"
    t.rspec_opts = ["--color", "--backtrace"]
  end

  task :all => [ :unit, :integration ]
end
task :test => [ :"test:all" ]