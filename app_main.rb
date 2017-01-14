require 'sinatra'
require 'line/bot'
require './message'
require './event_template'

# 微小変更部分！確認用。
get '/' do
  "Hello world"
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
    case event
    when Line::Bot::Event::Message
      case event.type
      when Line::Bot::Event::MessageType::Text

        if event.message['text'] =~ /テンプレート/
          client.reply_message(event['replyToken'], reply_template)

        elsif event.message['text'] =~ /イベント/
          title = 'title'
          location = 'location'
          fee = "fee"
          body = "body"
          image = "https://example.com/bot/images/item1.jpg"
          num = 1
#            client.reply_message(event['replyToken'], event_template(title, location, fee, body, image, num))
            client.reply_message(event['replyToken'], event_template)

        else
          client.reply_message(event['replyToken'], reply_message(event.message['text']))
        end


      when Line::Bot::Event::MessageType::Image, Line::Bot::Event::MessageType::Video
        response = client.get_message_content(event.message['id'])
        tf = Tempfile.open("content")
        tf.write(response.body)
      end
    end
  }

  "OK"
end
