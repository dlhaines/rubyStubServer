# config.ru (run with rackup)

require './stubToDisk'
require 'logger'

data_dir = ENV['DATA_DIR']

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

# The value of ENV['PORT'] is used by rackup.  The data directory value is passed here to the server.
run App.new(data_dir)

