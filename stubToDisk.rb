# Map url to disk files.  Path elements of the url map to directories. Final element maps
# to a file.  Query parameters map to parts of the requested file name.  If directory is found
# but no matching file then the default file (default.json) in that directory is returned.
# If no file is found then return 404.
# Only handles json files for now.

# TTD:
# does not use query parameters.
# startup script that takes port
# startup script that takes optional base directory
# add logging

require 'sinatra'
require 'slim'
require 'json'
require_relative 'stub_helpers'

class App < Sinatra::Base

  include StubHelpers

  # Add explicit initialize method so can pass in startup parameters.  Those
  # parameters are referenced as instance variables.
  def initialize(base_dir)
    super
    @base_dir = base_dir
  end

  # for all queries find the associated file.  If there is no file or default file
  # then return a 404.

  get '*' do
    content_type :json

    path_info = request.env["PATH_INFO"]
    rx = Regexp.new("^(.*)/([^/]*)$")
    file_match = rx.match(path_info)

    file_path,file_name = file_match[1],file_match[2]

    file_request = getDiskFileName(@base_dir,file_path, file_name)

    # Go get the file.  If there is an error return a 404.
    contents = nil

    begin
      contents = getDiskFile(file_request)
    rescue Errno::EISDIR => isdir_err
      #puts "isdir_err exception: [#{isdir_err}]"
    rescue Exception => exp
      #puts "getDiskFile exception: [#{exp.inspect}] class: [#{$!}]"
    end

    halt 404 if contents.nil?

    contents
  end
end
