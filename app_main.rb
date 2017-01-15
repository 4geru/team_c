require 'bundler/setup'
Bundler.require
require 'sinatra/reloader' if development?

require 'sinatra'
require 'line/bot'
require './message'
require './models/genre.rb'
require './event_template'

get '/' do
  "Hello world"
end

get '/date' do
  reply_template_date.to_s
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
        if event.message['text'] =~ /いいね/
          client.reply_message(event['replyToken'], reply_template_date)
        elsif event.message['text'] =~ /ジャンル/
          client.reply_message(event['replyToken'], reply_rand_genre)
        elsif event.message['text'] =~ /テンプレート/
          client.reply_message(event['replyToken'], reply_template)
        elsif event.message['text'] =~ /イベント/
          title = 'title'
          location = 'location'
          fee = "fee"
          body = "body"
          image = "https://example.com/bot/images/item1.jpg"
          client.reply_message(event['replyToken'], art_template(title, location, fee, body, image))
        else
          client.reply_message(event['replyToken'], reply_message(event.message['text']))
        end
      when Line::Bot::Event::MessageType::Image, Line::Bot::Event::MessageType::Video
        response = client.get_message_content(event.message['id'])
        tf = Tempfile.open("content")
        tf.write(response.body)
      when Line::Bot::Event::Postback
        client.reply_message(event['replyToken'], reply_message('反応したよ'))
      end
    end
  }

  "OK"
end
