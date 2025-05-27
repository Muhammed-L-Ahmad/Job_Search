require "sinatra"
require "sinatra/reloader"

careerjet_api_key = ENV.fetch("SEARCH_API_KEY")

# ask the user the title of the job they want to search for
pp "What is the title of the job you'd like to search for?"

  job_title = gets.chomp

get("/") do
  erb(:root)
end

get("/search")
  erb(:search)
end

get("/search/results")
  erb(:search_results)
end
