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

  what = params.fetch "what"
  where = params.fetch "where"

  # TODO: Comment out everything and uncomment one piece at a time - not uncommenting the next piece until the previous piece works.

  adzuna_app_url ="https://api.adzuna.com/v1/api/jobs/us/search/1?app_id=#{adzuna_app_id}&app_key=#{adzuna_app_key}&results_per_page=1&what=#{what}&where=#{where}"
  # adzuna_app_url = "https://api.adzuna.com/v1/api/jobs/us/search/1?app_id=#{adzuna_app_id}&app_key=#{adzuna_app_key}&results_per_page=5&"+ what.gsub(" ") + where.gsub(" ", "%20") + "&key="

  puts adzuna_app_url
  # TODO: send the request using HTTP class
  # Parse response using JSON class
  # Dig through the respnse

  raw_adzuna_response = HTTP.get(adzuna_app_url)
  parsed_adzuna_response = JSON.parse(raw_adzuna_response)
  parsed_adzuna_response.dig("Job", "Company", "Location")
  # results_hash = parsed_adzuna_response.fetch("results")
  # first_result = results_hash.to_s
  @what_hash = parsed_adzuna_response.fetch("Job")
  @who_hash = parsed_adzuna_response.fetch("Company")
  @where_hash = parsed_adzuna_response.fetch("Location")
  puts "Results for " + @what_hash + ", " + @where_hash + ": " + @results_hash
  erb(:results)
end



  # result = adzuna_app_url.search({
  #   keywords: params[:keywords],
  #   location: params[:location],
  #   page: 1
  # })

  # @jobs = result['jobs']
