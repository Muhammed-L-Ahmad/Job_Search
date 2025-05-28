require "sinatra"
require "sinatra/reloader"
require 'careerjet-api-client'

get("/") do
  erb(:search)
end

get("/search") do
  api = Careerjet::API.new('en_US')
  

  result = api.search({
    keywords: params[:keywords],
    location: params[:location],
    page: 1
  })

  @jobs = result['jobs']
  erb(:results)
end

set :bind, '0.0.0.0'
set :port, 9292
