# config.ru (run with rackup)
require './stubToDisk'
require 'logger'
DATA_DIR='/Users/dlhaines/dev/GITHUB/dlh-umich.edu/rubyStubServer/test/test-files/data'

### uncomment this if want log to a file.
#
# log = File.new("sinatra.log", "w+")
#   $stdout.reopen(log)
#   $stderr.reopen(log)
#   $stderr.sync=true
#   $stdout.sync=true
#
# use Struct.new(:app) {
#   def call(env)
#     env["rack.errors"] = $stdout
#     app.call(env)
#   end
# }
#
# #use Rack::Logger, $your_log_level
# use Rack::Logger, Logger::ERROR
# use Rack::CommonLogger
  
run App.new(DATA_DIR)

