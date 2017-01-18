require 'sinatra'
require 'line/bot'
require './messages'
require './library'
require './models/keeps'
require 'json'

get '/' do
#  reply_carousel_museums(reply_museum_datas).to_s
  reply_carousel_bookmarks.to_s
  #  params(str.to_hash)
end

def client
	@client ||= Line::Bot::Client.new { |config|
    config.channel_secret = ENV["LINE_CHANNEL_SECRET"]
    config.channel_token = ENV["LINE_CHANNEL_TOKEN"]
  }
end

post '/callback' do
  body = request.body.read

  signature = request.env['HTTP_X_LINE_SIGNATURE']
  unless client.validate_signature(body, signature)
    error 400 do 'Bad Request' end
  end

  events = client.parse_events_from(body)
  events.each { |event|
    puts event.class
    case event
    
    when Line::Bot::Event::Message
      case event.type
      when Line::Bot::Event::MessageType::Text
        if event.message['text'] =~ /あずみん起きて/
          client.reply_message(event['replyToken'], reply_confirm_start)
        if event.message['text'] =~ /寝かせて/
          #client.reply_message(event['replyToken'], reply_message('少しお待ちください'))
          client.reply_message(event['replyToken'], reply_carousel_museums(reply_museum_datas))
        elsif event.message['text'] =~ /情報/
          client.reply_message(event['replyToken'], reply_template_museum(reply_museum_data))
        elsif event.message['text'] =~ /ブックマーク/
          channel = get_id(event["source"])
          client.reply_message(event['replyToken'], reply_carousel_bookmarks(channel))
        elsif event.message['text'] == '今日行きたい'
          client.reply_message(event['replyToken'], reply_message("今日だね。\nこんなのはどうかな？"))
        elsif event.message['text'] == '明日行きたい'
          client.reply_message(event['replyToken'], reply_message("今日だね。\nこんなのはどうかな？"))
        elsif event.message['tilte'] = '週末行きたい'
          client.reply_message(event['replyToken'], reply_message("週末だね。\nこんなのはどうかな？"))
        elsif event.message['title'] == '決まってない'
          client.reply_message(event['replyToken'], reply_message("じゃあ、今開催中のイベントを紹介するね。\nこんなのはどうかな？"))
        else
          client.reply_message(event['replyToken'], reply_message(event.message['text']))
        end
      when Line::Bot::Event::MessageType::Image, Line::Bot::Event::MessageType::Video
        response = client.get_message_content(event.message['id'])
        tf = Tempfile.open("content")
        tf.write(response.body)
      end

    # Postbackの場合
    when Line::Bot::Event::Postback
      puts 'get postback'
      if event["postback"]["data"] =~ /行きたい/
        client.reply_message(event['replyToken'], reply_botton_schedule)
      elsif event["postback"]['data'] =~ /呼んだだけ/
        client.reply_message(event['replyToken'], reply_message('もう (おこ)'))
      elsif event["postback"]["data"] =~ /今日だね/
        client.reply_message(event['replyToken'], reply_carousel_museums(reply_museum_datas))
      elsif event["postback"]["data"] =~ /明日だね/
        client.reply_message(event['replyToken'], reply_carousel_museums(reply_museum_datas))
      elsif event["postback"]["data"] =~ /週末だね/
        client.reply_message(event['replyToken'], reply_carousel_museums(reply_museum_datas))
      elsif event["postback"]["data"] =~ /決まっていない/
        client.reply_message(event['replyToken'], reply_carousel_museums(reply_museum_datas))
      else 
        data = param_decode(event["postback"]["data"])
        puts data.to_s
        client.reply_message(event['replyToken'], reply_message("type は"+data['title']))
        channel_id = get_id(event["source"])
        Keep.create(:channel=>channel_id, :json=>event["postback"]["data"])
        client.reply_message(event['replyToken'], reply_message(data['title'] + 'をブックマークしました!'))
      end
    else 
    end
  }
  "OK"
end
