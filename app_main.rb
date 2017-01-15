require 'bundler/setup'
Bundler.require
require 'sinatra/reloader' if development?

require 'sinatra'
require 'line/bot'

require 'logger'
 
log = Logger.new('~')

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
    puts 'get event'
    case event
    when Line::Bot::Event::Message
      case event.type
      when Line::Bot::Event::MessageType::Text
        puts 'get message'
        puts event.type
        puts event.message['text']
        puts event['replyToken']
        message = {
            "type": "image",
            "originalContentUrl": "https://screenshots.jp.sftcdn.net/jp/scrn/3346000/3346031/image-05-544x535.png",
            "previewImageUrl": "https://screenshots.jp.sftcdn.net/jp/scrn/3346000/3346031/image-05-544x535.png"
        }
        puts message.to_s
        puts client.reply_message(event['replyToken'], message)
        puts client.reply_message(event['replyToken'], message).body
        client.reply_message(event['replyToken'], message)
        puts 'reply message'
      when Line::Bot::Event::MessageType::Image, Line::Bot::Event::MessageType::Video
        response = client.get_message_content(event.message['id'])
        tf = Tempfile.open("content")
        tf.write(response.body)
      end
    end
  }

  "OK"
end