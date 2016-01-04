require 'rake/testtask'

namespace :test do

  desc "available tests are: [ blah blah blah :test:all, :test:local, :test_integration, :test_resources]"
  task :all => [:resources]

## default unit tests

## specific tests
  Rake::TestTask.new do |t|
    t.libs << "test"
    t.name = "resources"
    t.description = "Check file implementation of stub"
    t.test_files = FileList['**/test_file_a*.rb']
    t.verbose = true
  end
end
