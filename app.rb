require "sinatra"
require "sinatra/reloader"
require "http"
require "dotenv/load"

get("/") do
  erb(:search)
end

get("/results") do
  adzuna_app_id = ENV.fetch("ADZUNA_APP_ID")
  adzuna_app_key = ENV.fetch("ADZUNA_APP_KEY")

  adzuna_app_url = "https://api.adzuna.com/v1/api/jobs/us/search/1?app_id=#{adzuna_app_id}&app_key=#{adzuna_app_key}"
  # TODO: send the request using HTTP class
  # Parse response using JSON class
  # Dig through the respnse

  raw_adzuna_response = HTTP.get(adzuna_app_url)
  parsed_adzuna_response = JSON.parse(raw_adzuna_response)
  results_hash = parsed_adzuna_response.fetch("results")
  # first_result = results_hash.to_s
  @what_hash = results_hash.fetch("Job").to_s
  @who_hash = results_hash.fetch("Company").to_s
  @where_hash = results_hash.fetch("Location").to_s
# lat = location_hash.fetch("lat")
# lng = location_hash.fetch("lng")
  puts "Results for " + @what_hash.to_s + ", " + @where_hash.to_s + ": " + @results_hash
  erb(:results)
end



  # result = adzuna_app_url.search({
  #   keywords: params[:keywords],
  #   location: params[:location],
  #   page: 1
  # })

  # @jobs = result['jobs']
