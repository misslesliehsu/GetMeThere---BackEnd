require 'protobuf'
require 'google/transit/gtfs-realtime.pb'
require 'net/http'
require 'uri'
require 'time'

class Api::V1::FaveTrainsController < ApplicationController


  def index
    result = {}
    @fave_trains = User.find(params[:user_id]).fave_trains
    @fave_trains.each do |ft|
      data = Net::HTTP.get(URI.parse("http://datamine.mta.info/mta_esi.php?key=cc49bf175fd71f9b67ff33c1ef07f629&feed_id=#{ft.train.Mta_Id}"))
      feed = Transit_realtime::FeedMessage.decode(data)
      output = translate(feed[:entity])
      target = ft.station.coded + ft.direction #"702N"
      line_and_stop = ft.train.line + " - " + ft.station.regular + " - " + ft.direction #"6 - Bleecker St. - N"
      result[line_and_stop] = output[target] #"6 - Bleecker St. => [1,4,6]"
    end
    puts result
    render json: result.to_json
  end


  def translate(array)
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




    #create new fave_train for a given user
    def create
      @fave_train = FaveTrain.new(user_id: params[:user_id], train_id: params[:id].to_i, station_id: params[:user_id], direction: params[:direction])
      if @fave_train.valid?
        @fave_train.save
        render json: @fave_train
      else
        render json: {errors: @fave_train.errors.full_messages}, status: 500
      end
    end

    def destroy
      @fave_train = Fave_train.find(params[:id])
      @fave_train.destroy
    end


end
