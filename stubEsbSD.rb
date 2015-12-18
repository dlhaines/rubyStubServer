## Server to sub StudentDashboard API data.  Start the server
## and goto the /api URL for a description.

require 'sinatra'
require 'slim'
require 'json'

## api description
@@apidoc = <<END
<html>
<body)
<p/>
HOST: - Returns stub data for requests to the StudentDashboard API.
It recognizes requests of the form:
 <p/>
/StudentDashboard/v1/Students/:name/Terms/:terms/Schedule' 
and 
<p/>
/StudentDashboard/v1/Students/:name/Terms'
<p/>
The values in the URL corresponding to :name and :terms value will be used to
check for a file with a matching name.  E.g. A request for /StudentDashboard/v1/Students/kermit/Terms/2010/Schedule
would return the contents of a file named data/kermit.2010.schedule.data if it exists.  Otherwise
it will return the contents of data/default.schedule.data.
<p/>
The data directory will be in the same directory as the server.
</body>
</html>
END

## respond to request for api description.
get '/api' do
  content_type :html
  @@apidoc
end

#respond to schedule request
#https://woodpigeon.dsc.umich.edu:8243/StudentDashboard/v1/Students/ststvii/Terms/2010/Schedule

get '/StudentDashboard/v1/Students/:name/Terms/:terms/Schedule' do
  content_type :json
  file_name = "data/#{params[:name]}.#{params[:terms]}.schedule.data"
  file_name = "data/default.schedule.data"  if !File.exists?(file_name)
  
  data = File.read(file_name)
end

#respond to term request
#https://woodpigeon.dsc.umich.edu:8243/StudentDashboard/v1/Students/ststvii/Terms
get '/StudentDashboard/v1/Students/:name/Terms' do
  content_type :json
  file_name = "data/#{params[:name]}.terms.data"
  file_name = "data/default.terms.data" if !File.exists?(file_name)
  
  data = File.read(file_name)
end

