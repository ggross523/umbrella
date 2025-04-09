# Write your solution below!


require "http"
require "json"
require "dotenv/load"


pp "=================================="
pp "Will you need an umbrella today"
pp "=================================="
pp "Where Are You"

user_location = gets.chomp
env_fetch_gmap = ENV.fetch("GMAPS_KEY")
google_api = "https://maps.googleapis.com/maps/api/geocode/json?address=#{user_location.gsub(" ", "%20")}&key=#{env_fetch_gmap}"


resp = HTTP.get(google_api)
raw_body = resp.to_s

parsed_body = JSON.parse(raw_body)
lat = parsed_body.fetch("results").at(0).fetch("geometry").fetch("location").fetch("lat")
lng = parsed_body.fetch("results").at(0).fetch("geometry").fetch("location").fetch("lng")


env_fetch_pirate = ENV.fetch("PIRATE_WEATHER_KEY")
pirate_api = "https://api.pirateweather.net/forecast/#{env_fetch_pirate}/#{lat},#{lng}"

respp = HTTP.get(pirate_api)
raw_body_p = respp.to_s

parsed_body_p = JSON.parse(raw_body_p)
rain_odds = parsed_body_p.fetch("currently").fetch("precipProbability")

if rain_odds >= 0.50
  pp "Bring an umbrella or your ass will be sloppy as hell"
  else rain_odds < 0.50
    pp "You good"
  end
