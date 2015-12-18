## Server to sub StudentDashboard API data.  Start the server
## and goto the /api URL for a description.

require 'sinatra'
require 'slim'
require 'json'

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

