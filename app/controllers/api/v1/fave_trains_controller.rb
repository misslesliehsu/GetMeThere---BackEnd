require 'protobuf'
require 'google/transit/gtfs-realtime.pb'
require 'net/http'
require 'uri'

class Api::V1::FaveTrainsController < ApplicationController

  def show
    @fave_train = FaveTrain.find_by(user_id: params[:user_id], train_id: params[:id].to_i)

    # data = Net::HTTP.get(URI.parse("http://datamine.mta.info/mta_esi.php?key=cc49bf175fd71f9b67ff33c1ef07f629&feed_id=#{@fave_train.train.Mta_Id}"))
    data = Net::HTTP.get(URI.parse("http://datamine.mta.info/mta_esi.php?key=cc49bf175fd71f9b67ff33c1ef07f629&feed_id=31"))
    feed = Transit_realtime::FeedMessage.decode(data)

    render json: feed.to_json
  end

end
