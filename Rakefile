require 'rake/testtask'

# default is to test
task :default => ["test"]


desc "Starts the default web server through rackup, set port and data directory via environment variables PORT and DATA_DIR.  E.g. task server PORT=6666 DATA_DIR=/etc/password"
task :server do

  ENV['PORT'] = '9292' if ENV['PORT'].nil?
  ENV['DATA_DIR'] = "#{Dir.pwd}/test/test-files/data" if ENV['DATA_DIR'].nil?
  puts "PORT: [#{ENV['PORT']}] DATA_DIR: [#{ENV['DATA_DIR']}]"
  %x[rackup -p #{ENV['PORT']}]
end

######## Configure tests

# Run all tests if just specify the 'test' task.
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
    t.description = "Verify file implementation of stub"
    t.test_files = FileList['**/test_file_*.rb']
    t.verbose = true
  end

  ## test with rack mock server.
  Rake::TestTask.new do |t|
    t.libs << "test"
    t.name = "server"
    t.description = "Verify server via rack"
    t.test_files = FileList['**/test_app*.rb']
    t.verbose = true
  end
  
  ## things left to do
  Rake::TestTask.new do |t|
    t.libs << "test"
    t.name = "TTD"
    t.description = "Document for things to do (TTD)"
    t.test_files = FileList['**/test_TTD*.rb']
    t.verbose = true
  end
end

#end
