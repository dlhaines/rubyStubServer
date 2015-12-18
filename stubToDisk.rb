# Map url to disk files.  Path elements of the url map to directories. Final element maps
# to a file.  Query parameters map to parts of the requested file name.  If directory is found
# but no matching file then the default file in that directgry is returned. default.json is returned.
# If no file is found then return 404.
# Only handles json files for now.

# TTD:
# does not use query parameters.
# startup script that takes port
# startup script that takes optional base directory

require 'sinatra'
require 'slim'
require 'json'

# Currently look for a 'data' directory below the current working directory.

set :base_dir, "./data"

helpers do

  # find the name of the corresponding file on disk using base_dir and defaulting file name.
  # return nil if no matching file is found.  It assumes no query parameters.
  def getDiskFileName(file_path, file_name)

    puts "dfn: file_path: [#{file_path}] file_name: [#{file_name}]"
    full_file_path = settings.base_dir

    if !file_path.nil? && file_path.length > 0
      full_file_path = "#{full_file_path}#{file_path}"
    end

    if File.exists? ("#{full_file_path}/#{file_name}")
      return "#{full_file_path}/#{file_name}"
    end

    if File.exists? ("#{full_file_path}/default.json")
      return "#{full_file_path}/default.json"
    end

    nil
  end

  # Return contents of the named disk file.  Only
  # files known to exist should be referenced.
  def getDiskFile(full_disk_file)
    unless full_disk_file.nil?
      return File.read(full_disk_file)
    end

    halt 404
  end

end

# testing
get '/' do
  "@base_dir: [#{settings.base_dir}]"
end

# for all queries find the associated file.
get '*' do
  content_type :json

  path_info = request.env["PATH_INFO"]
  rx = Regexp.new("^(.*)/([^/]*)$")
  file_match = rx.match(path_info)

  file_path = file_match[1]
  file_name = file_match[2]

  file_request = getDiskFileName(file_path, file_name)

  getDiskFile(file_request)
end


# def getWrappedDiskFile(data_file)
#   logger.debug "#{__method__}: #{__LINE__}: DPFC: data file string: "+data_file
#   if File.exists?(data_file)
#     logger.debug "#{__method__}: #{__LINE__}: DPFC: file exists: #{data_file}"
#     classes = File.read(data_file)
#
#     wrapped = WAPIResultWrapper.value_from_json(classes);
#
#     # if it isn't valid then just wrap what did come back.
#     unless wrapped.valid?
#       wrapped = WAPIResultWrapper.new(200, "found file #{data_file}", classes)
#     end
#
#   else
#     logger.debug "#{__method__}: #{__LINE__}: DPFC: file does not exist: #{data_file}"
#     wrapped = WAPIResultWrapper.new(404, "File not found", "Data provider from files did not find a matching file for #{data_file}")
#   end
#
#   logger.debug "#{__method__}: #{__LINE__}: DPFC: returning: "+wrapped.to_s
#   return wrapped
# end

## end
