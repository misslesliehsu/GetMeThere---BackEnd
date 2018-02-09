load './Users/aiw392/.rvm/gems/ruby-2.3.3/gems/gtfs-realtime-bindings-0.0.5/lib/google/transit/gtfs-realtime.pb.rb'
require 'net/http'
require 'uri'

class Api::V1::FaveTrainsController < ApplicationController

  def show
    @fave_train = FaveTrain.find_by(user_id: params[:user_id], train_id: params[:id].to_i)

    data = Net::HTTP.get(URI.parse("http://datamine.mta.info/mta_esi.php?key=cc49bf175fd71f9b67ff33c1ef07f629&feed_id=#{@fave_train.train.Mta_Id}"))
    feed = Transit_realtime::FeedMessage.decode(data)
    for entity in feed.entity do
      if entity.field?(:trip_update)
        render json: entity.trip_update.to_json
      end
    end

  end

end
