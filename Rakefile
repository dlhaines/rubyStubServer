require 'rake/testtask'

# default is to test
task :default => ["test"]

# define tests

task :test => ["test:all"]
namespace :test do

  desc "available tests are: [:test:all, :test:files]"
  task :all => [:files]
  
## specific tests
  Rake::TestTask.new do |t|
    t.libs << "test"
    t.name = "files"
    t.description = "Check file implementation of stub"
    t.test_files = FileList['**/test_file_*.rb']
    t.verbose = true
  end
end

#end
