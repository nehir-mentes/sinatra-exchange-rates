require "sinatra"
require "sinatra/reloader"
require "dotenv/load"

# Pull in the HTTP class
require "http"

# define a route for the homepage
get("/") do

  # Assemble the API url, including the API key in the query string
  api_url = "https://api.exchangerate.host/list?access_key=#{ENV.fetch("EXCHANGE_RATE_KEY")}"

  # Use HTTP.get to retrieve the API data
  @raw_response = HTTP.get(api_url)

  # Get the body of the response as a string
  @raw_string = @raw_response.to_s

  # Convert the string to JSON
  @parsed_data = JSON.parse(@raw_string)

  # View the currencies
  @currencies = @parsed_data.fetch("currencies")

  # Render a view template
  erb(:homepage)
end

# Build the target
get ("/:first_symbol") do

  @the_symbol = params.fetch("first_symbol")

    # Assemble the API url, including the API key in the query string
    api_url = "https://api.exchangerate.host/list?access_key=#{ENV.fetch("EXCHANGE_RATE_KEY")}"

    # Use HTTP.get to retrieve the API data
    @raw_response = HTTP.get(api_url)
  
    # Get the body of the response as a string
    @raw_string = @raw_response.to_s
  
    # Convert the string to JSON
    @parsed_data = JSON.parse(@raw_string)
  
    # View the currencies
    @currencies = @parsed_data.fetch("currencies")
  
    # Render a view template
    erb (:target_currency)
end
