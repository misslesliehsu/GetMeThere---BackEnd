require 'protobuf'
require 'google/transit/gtfs-realtime.pb'
require 'net/http'
require 'uri'
require 'time'

class Api::V1::TrainsController < ApplicationController

  def show
    train = Train.find_by(line: params[:id])
    data = Net::HTTP.get(URI.parse("http://datamine.mta.info/mta_esi.php?key=cc49bf175fd71f9b67ff33c1ef07f629&feed_id=#{train.Mta_Id}"))
    feed = Transit_realtime::FeedMessage.decode(data)
    interim = translate(feed[:entity])
    output = []
    interim.each do |k,v|
      indiv = {}
      indiv["coded"] = k[0,3]
      indiv["regular"] = Station.find_by(coded: k[0,3]).regular
      indiv["direction"] = k[3]
      indiv["line"] = train.line
      indiv["times"] = v
      output.push(indiv)
    end
    render json: output.to_json
  end
    # interim = Array(feed[:entity])
    # output = []
    # # debugger
    # interim.select! do |y|
    #   y[:trip_update]
    # end
    # interim.select! do |z|
    #   z[:trip_update][:trip][:route_id] == params[:id]
    # end
    # interim2=Array(interim)
    # interim2[:trip_update][:trip][:stop_time_update].each do |x|
    #   indiv = {}
    #   indiv["coded"] = x[:stop_id][0,3]
    #   indiv["regular"] = Station.find_by(coded: x[:stop_id][0,3]).regular
    #   indiv["direction"] = x[:stop_id][3]
    #   indiv["line"] = train.line
    #   indiv["times"] = x[:arrival][:time]
    #   output.push(indiv)
    # end
    #
    # render json: output.to_json
  # end









  def translate(array)

    # trip_update[:trip][:route_id] = "G"
    # trip_update[:stop_time_update][:arrival][:time] = 12513139280934
    # trip_update[:stop_time_update][:stop_id] = F25S



    train_hash = {}
    array.each_with_index do |o, i|
      if i % 2 == 0 || i == 0
          o[:trip_update][:stop_time_update].each do |x|
            stop = x[:stop_id]
            arrival_time = x[:arrival][:time]
            if train_hash.include?(stop)
              train_hash[stop].push(arrival_time)
            else
            train_hash[stop] = [arrival_time]
            end
          end
      end
    end

    train_hash.collect do |k, v|
      train_hash[k] = v.map! do |time|
        (time - Time.now.to_i) / 60
      end
      if v.length > 3 then v.pop(v.length - 3) end
      train_hash[k] = v.select do |x| x >= 0 end
    end
    train_hash
  end


end
