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

# From currency
get ("/:from_currency") do

  @from_currency = params.fetch("from_currency")

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

# Second symbol
get ("/:from_currency/:to_currency") do

  @from_currency = params.fetch("from_currency")
  @to_currency = params.fetch("to_currency")

    # Assemble the API url, including the API key in the query string
   
    api_url = "https://api.exchangerate.host/convert?from=#{@from_currency}&to=#{@to_currency}&amount=1&access_key=#{ENV.fetch("EXCHANGE_RATE_KEY")}"

    # Use HTTP.get to retrieve the API data
    @raw_response = HTTP.get(api_url)

    # Get the body of the response as a string
    @raw_string = @raw_response.to_s
  
    # Convert the string to JSON
    @parsed_data = JSON.parse(@raw_string)

    # View the exchange rate
    @exchange_rate = @parsed_data.fetch("result")

    # Render a view template
    erb (:conversion)
end
