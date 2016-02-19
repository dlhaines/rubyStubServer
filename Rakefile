require 'rake/testtask'

#### TTD
# - share the startup code between server configurations
# - print settings
# - allow multiple servers?

# default is to test
task :default => ["test"]


#### tasks to run default server
desc "+++ Start and stop test server"
task :server

# can't get daemonize and logging to work, so use this
#rake server:start_canvas &

namespace :server do
  desc "Starts the default stub web server through rackup, set port and data directory via environment variables PORT and DATA_DIR.  E.g. task server PORT=6666 DATA_DIR=/etc/password"
  task :start_demo01 do
    ENV['MIN_WAIT'] = '0.0' if ENV['MIN_WAIT'].nil?
    ENV['MAX_WAIT'] = '0.0' if ENV['MAX_WAIT'].nil?
    ENV['PORT'] = '9100' if ENV['PORT'].nil?
    ENV['DATA_DIR'] = "#{Dir.pwd}/test/test-files/data" if ENV['DATA_DIR'].nil?
    puts "PORT: [#{ENV['PORT']}] DATA_DIR: [#{ENV['DATA_DIR']}] MIN_WAIT: [#{ENV['MIN_WAIT']}] MAX_WAIT: [#{ENV['MAX_WAIT']}]"
    %x[rackup -s thin -p #{ENV['PORT']} -o '0.0.0.0' --pid tmp/pids/thin.pid >| tmp/log/stub.$$.log 2>&1]
  end

  desc "start standard canvas on localhost 9100"
  task :start_canvas do
    ENV['MIN_WAIT'] = '0.0' if ENV['MIN_WAIT'].nil?
    ENV['MAX_WAIT'] = '0.0' if ENV['MAX_WAIT'].nil?
    ENV['PORT'] = '9100' if ENV['PORT'].nil?
    ENV['DATA_DIR'] = "#{Dir.pwd}/standard/canvas" if ENV['DATA_DIR'].nil?
    puts "PORT: [#{ENV['PORT']}] DATA_DIR: [#{ENV['DATA_DIR']}] MIN_WAIT: [#{ENV['MIN_WAIT']}] MAX_WAIT: [#{ENV['MAX_WAIT']}]"
    %x[rackup -s thin -p #{ENV['PORT']} -o '0.0.0.0' --pid tmp/pids/thin.pid >| tmp/log/stub.$$.log 2>&1]
  end

  desc "Stops the server started by server:start"
  task :stop do
    puts "Killing server with pid #{%x[cat tmp/pids/thin.pid]}"
    %x[kill $(cat tmp/pids/thin.pid)]
  end

end

######## Configure tests

# Run all tests if just specify the 'test' task.
desc " Testing tasks"
task :test => ["test:all"]

# define the test taskso
namespace :test do
  desc "+++ available tests are: [:test:all, :test:files]"
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

######################################################
## commands to setup and run vagrant VM with Dashboard
desc "+++ Commands to setup and run Vagrant VM for Dashboard testing"
task :vagrant

namespace :vagrant do
  desc "Make the application build artifacts available for creating the VM"
  task :get_artifacts do
    sh "(cd vagrant; ./getArtifacts.sh)"
  end

  desc "Starts the Vagrant VM, creating it if necessary"
  task :up => :get_artifacts do
    sh "(cd vagrant; vagrant up)"
  end

  desc "Same as the halt task"
  task :down => :halt

  desc "Stop VM and destroy it"
  task :destroy do
    sh "(cd vagrant; vagrant destroy -f)"
  end

  desc "Halt (stop) the vagrant VM but do not delete it"
  task :halt do
    sh "(cd vagrant; vagrant halt)"
  end

  desc "Open a (debug) xterm to the vagrant VM, YMMV."
  task :xterm do
    sh "(cd vagrant; ./vagrantXterm.sh)"
  end

  desc "Open a ssh terminal connection to the vagrant VM."
  task :ssh do
    sh "(cd vagrant; vagrant ssh)"
  end

  desc "Reload changes into the existing VM.  Avoids redoing initial OS updates."
  task :reload => :get_artifacts do
    sh "(cd vagrant; vagrant reload --provision)"
  end
end

#end
