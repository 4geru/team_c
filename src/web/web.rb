
get '/' do
  reply_stamp_original.to_s
end

get '/museum' do
  reply_carousel_museums(museum_datas).to_s
end

def client
  @client ||= Line::Bot::Client.new { |config|
    config.channel_secret = ENV["LINE_CHANNEL_SECRET"]
    config.channel_token = ENV["LINE_CHANNEL_TOKEN"]
  }
end
