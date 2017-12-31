def postback(event)
  channel_id = get_id(event["source"])
  data = param_decode(event["postback"]["data"])
  case data["type"]
  when "reply"
    case data["word"]
    when "あずみん行きたい"
      client.reply_message(event['replyToken'], reply_botton_schedule)
    when "呼んだだけ"
      client.reply_message(event['replyToken'], 'もう (おこ)'.replyMessage)
    when "今日だね", "明日だね", "週末だね"
      client.reply_message(event['replyToken'], "おっけー！\nオススメ  検索するから少し待っててー".replyMessage)
    when "決まっていない"
      client.reply_message(event['replyToken'], "おっけー！\nオススメ  検索するから少し待っててー".replyMessage)
    end
  when "keep"
    Keep.create(:channel=>channel_id, :json=>event["postback"]["data"])
    client.reply_message(event['replyToken'], "#{data['title']} をメモったよ！".replyMessage)
  when "destroy"
    puts "#{channel_id} -> #{event['postback']['data']}"
    destroy_memo(channel_id,event['postback']['data'])
  when "gps"
    case data["source_page"]
    when 'museum'
      client.reply_message(event['replyToken'], reply_gps(data['title'],data['address'],data['latitude'],data['longitude']))
    end
  end
end