require 'rake/testtask'

# default is to test
task :default => ["test"]

# define tests

# define tests run if just invoke "test" task.
task :test => ["test:all"]
# define the test tasks
namespace :test do
  desc "available tests are: [:test:all, :test:files]"
  task :all => [:files, :server, :TTD]
  
  ## specific tests
  # test file name and file handling.
  Rake::TestTask.new do |t|
    t.libs << "test"
    t.name = "files"
    t.description = "Check file implementation of stub"
    t.test_files = FileList['**/test_file_*.rb']
    t.verbose = true
  end

  ## test with rack mock server.
  Rake::TestTask.new do |t|
    t.libs << "test"
    t.name = "server"
    t.description = "Test server via rack"
    t.test_files = FileList['**/test_app*.rb']
    t.verbose = true
  end
  
  ## things left to do
  Rake::TestTask.new do |t|
    t.libs << "test"
    t.name = "TTD"
    t.description = "Tests for things to do (TTD)"
    t.test_files = FileList['**/test_TTD*.rb']
    t.verbose = true
  end
end

#end
