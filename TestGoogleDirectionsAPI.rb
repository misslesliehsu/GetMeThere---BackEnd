require 'net/http'
require 'json'

url = 'https://maps.googleapis.com/maps/api/directions/json?origin=165+Bleecker+Street+NewYork+NY+10012&destination=Flatiron+School+New+York&mode=transit&key=AIzaSyC-RAiivNb7-6RRTvB150W7wgSuRhi1Ryc'
uri = URI(url)
response = Net::HTTP.get(uri)
JSON.parse(response)

puts response
