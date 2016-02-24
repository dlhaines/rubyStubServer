# Map url requests to disk files.  Path elements of the url map to directories. Final element maps
# to a file.  Query parameters map to parts of the requested file name.  If directory is found
# but no matching file then the default file (default.json) in that directory is returned.
# If there is not an exact match and there no default.json file in that directory then return 404.
# Only handles json files for now.

# TTD:
# does not know about query parameters.
# way to reset the counts ? not through status
# have status vs status/counts
# have html and json
# have build info
# environment variables vs startup parameter?
# precompute wait range?
# periodic log dump (e.g. every 100 requests)
# test scripts

require 'sinatra'
require 'slim'
require 'json'
require_relative 'Logging'
require_relative 'stub_helpers'

class App < Sinatra::Base

  include StubHelpers
  include Logging


  # Put URL count hash in Sinatra environment.
  # Set URL count hash to have default 0,0 list entry.
  set :query_stats, Hash.new { |h, k| h[k] = [0, 0] }

  # record the start time
  query_stats[:CONFIG_START_NOW_TIME] = [Time.now().to_time.iso8601,0]

  configure do
    #set :logging, Logger::INFO
    set :logging, Logger::DEBUG

  end

  # Add explicit initialize method.  It will set values from
  # environment variables when specified.

  def initialize()
    super
    puts "init: DATA_DIR: [#{ENV['DATA_DIR']}]"
    query_stats = settings.query_stats
    min_wait = ENV['MIN_WAIT'].to_f || 0.0
    max_wait = ENV['MAX_WAIT'].to_f || 0.0
    query_stats[:CONFIG_WAIT_RANGE] = [min_wait, max_wait]
    query_stats[:CONFIG_DATA_DIR] = ENV['DATA_DIR'] || "."

  end

  # Treat status requests as special.  NOTE: should give normal status data.
  get '/status.?:format?/?' do |format|
    content_type :json
    stats = settings.query_stats
    # Add the current time.  That is only and always changed when this status url is accessed.
    stats[:CONFIG_START_NOW_TIME][1] = Time.now().to_time.iso8601
    logger.debug "stats: #{stats.to_json}"
    stats.to_json
  end

  # for all other queries find the associated file.  If there is no file or default file
  # then return a 404.
  
  get '*' do
    content_type :json

    stats = settings.query_stats
    
    logger.debug "path_info: #{request.env['PATH_INFO']}"

    path_info = request.env["PATH_INFO"]
    rx = Regexp.new("^(.*)/([^/]*)$")
    file_match = rx.match(path_info)

    file_path, file_name = file_match[1], file_match[2]

    file_request = getDiskFileName(stats[:CONFIG_DATA_DIR], file_path, file_name)

    min_wait, max_wait = stats[:CONFIG_WAIT_RANGE]
    will_wait = 0

    if max_wait - min_wait >= 0
      will_wait = rand(min_wait..max_wait)
      logger.debug "request wait: #{will_wait}"
      sleep will_wait
    end

    # update individual stats
    url_stats = stats[path_info]
    stats[path_info] = [url_stats[0]+1, (url_stats[1]+will_wait).round(3)]
    logger.debug "*: stats: #{stats.to_json}"

    # Go get the file.  If there is an error return a 404.
    contents = nil

    begin
      contents = getDiskFile(file_request)
    rescue Errno::EISDIR => isdir_err
      logger.warn "isdir_err exception: [#{isdir_err}]"
    rescue Exception => exp
      logger.warn "getDiskFile exception: [#{exp.inspect}] class: [#{$!}]"
    end

    logger.debug "file: #{file_request} contents: #{contents}"

    halt 404 if contents.nil?

    contents
  end

  post '*' do

  end

end
