require "sinatra"
require "sinatra/reloader"
require "http"
require "httparty"
require "dotenv/load"

get("/") do
  @jobs = []
  erb :index
end

post '/search' do
  puts "params: #{params}"
  query = params[:query]
  location = params[:location]
  country = 'us'

  response = HTTParty.get("https://api.adzuna.com/v1/api/jobs/#{country}/search/1", {
    query: {
      app_id: ENV['ADZUNA_APP_ID'],
      app_key: ENV['ADZUNA_APP_KEY'],
      what: query,
      where: location
    }
  })

  puts "response: #{response}"

  @jobs = response.parsed_response["results"] || []

  puts "jobs: #{@jobs}"
  erb :index
end
