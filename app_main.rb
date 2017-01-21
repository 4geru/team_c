require 'sinatra'
require 'line/bot'
require './messages'
require './library'
require './models/keeps'
require 'json'

get '/' do
#  return rand_asoview_genre.to_s
  reply_carousel_asoview(rand_asoview_genre).to_s
#  reply_carousel_museums(museum_datas).to_s
end

get '/asoview' do
  reply_carousel_asoview(rand_asoview_genre).to_s
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
        elsif event.message['text'] =~ /寝かせて/
          client.reply_message(event['replyToken'], reply_carousel_museums(museum_datas))
        elsif event.message['text'] =~ /情報/
          client.reply_message(event['replyToken'], reply_template_museum(reply_museum_data))
        elsif event.message['text'] =~ /メモ/ or event.message['text'] =~ /めも/ and not event.message['text'] =~ /ったよ！/
          channel = get_id(event["source"])
          client.reply_message(event['replyToken'], reply_carousel_memos(channel))
        elsif event.message['text'] =~ /あずみん/ and (event.message['text'] =~ /他/ or event.message['text'] =~ /ほか/ or event.message['text'] =~ /違う/ or event.message['text'] =~ /ちがう/)
          client.reply_message(event['replyToken'], [reply_message("こんなのもあるよー！"),reply_carousel_museums(museum_datas)])
        elsif event.message['text'] =~ /あずみん/ and (event.message['text'] =~ /あそ/ or event.message['text'] =~ /遊/)
          client.reply_message(event['replyToken'], reply_carousel_asoview(rand_asoview_genre))
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
      channel_id = get_id(event["source"])
      if event["postback"]["data"] =~ /行きたい/
        client.reply_message(event['replyToken'], reply_botton_schedule)
      elsif event["postback"]['data'] =~ /呼んだだけ/
        client.reply_message(event['replyToken'], reply_message('もう (おこ)'))
      elsif event["postback"]["data"] =~ /今日だね/
        destroy_memos(channel_id)
        client.reply_message(event['replyToken'], [reply_message("今日だね。\nこんなのはどうかな？"),reply_carousel_museums(museum_datas)])
      elsif event["postback"]["data"] =~ /明日だね/
        destroy_memos(channel_id)
        client.reply_message(event['replyToken'], [reply_message("明日だね。\nこんなのはどうかな？"),reply_carousel_museums(museum_datas)])
      elsif event["postback"]["data"] =~ /週末だね/
        destroy_memos(channel_id)
        client.reply_message(event['replyToken'], [reply_message("週末だね。\nこんなのはどうかな？"),reply_carousel_museums(museum_datas)])
      elsif event["postback"]["data"] =~ /決まっていない/
        destroy_memos(channel_id)
        client.reply_message(event['replyToken'], [reply_message("じゃあ、今開催中のイベントを紹介するね。\nこんなのはどうかな？"),reply_carousel_museums(museum_datas)])
      else 
        data = param_decode(event["postback"]["data"])
        case data["source_page"]
        when 'museum'
          case data["type"]
          when "keep"
            Keep.create(:channel=>channel_id, :json=>event["postback"]["data"])
            client.reply_message(event['replyToken'], reply_message(data['title'] + ' をメモったよ！'))
          when "gps"
            client.reply_message(event['replyToken'], reply_gps(data['title'],data['address'],data['latitude'],data['longitude']))
          when "destroy"
            Keep.destroy(:channel=>channel_id, :json=>event["postback"]["data"])
          end
        when 'asoview'
          puts data
          case data["type"]
          when "keep"
            Keep.create(:channel=>channel_id, :json=>event["postback"]["data"])
            client.reply_message(event['replyToken'], reply_message(data['title'] + ' をメモったよ！!'))
          when "gps"
            client.reply_message(event['replyToken'], reply_message(data['title']+" の場所は "+data['address']+" だよー！"))
          when "destroy"
            Keep.destroy(:channel=>channel_id, :json=>event["postback"]["data"])
          end
        end
      end
    else 
    end
  }
  "OK"
end
