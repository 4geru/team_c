def messageType(event)
  if event.message['text'] == "あずみん探してー！"
    return "検索するから少し待っててー".replyMessage
  elsif event.message['text'] =~ /あずみん週末行きたい/ or event.message['text'] =~ /あずみん明日行きたい/ or event.message['text'] =~ /あずみん今日行きたい/
    channel_id = get_id(event["source"])
    destroy_memos(channel_id)
    return reply_carousel_museums(museum_datas)
  elsif event.message['text'] =~ /あずみん決まってない/
    channel_id = get_id(event["source"])
    destroy_memos(channel_id)
    return reply_carousel_museums(museum_datas)
  elsif event.message['text'] =~ /あずみん/ and (event.message['text'] =~ /教えて/ or event.message['text'] =~ /おしえて/ or event.message['text'] =~ /イベント/ or event.message['text'] =~ /いべんと/)
    return  reply_confirm_start
  elsif event.message['text'] =~ /あずみん/ and (event.message['text'] =~ /メモ/ or event.message['text'] =~ /めも/) and not event.message['text'] =~ /ったよ！/
    channel = get_id(event["source"])
    return  reply_carousel_memos(channel)
  elsif event.message['text'] =~ /あずみん/ and (event.message['text'] =~ /他/ or event.message['text'] =~ /ほか/ or event.message['text'] =~ /違う/ or event.message['text'] =~ /ちがう/)
    return  ["こんなのもあるよー！".replyMessage,reply_carousel_museums(museum_datas)]
  elsif event.message['text'] =~ /あずみん/ and event.message['text'] =~ /かわいい/
    return  reply_stamp_original
  elsif event.message['text'] == "あずみん"
    return  "あずみんイベント！\n → アート系をオススメ！\n\nあずみん遊びたい！\n → アクティビティ系をオススメ！\n\nあずみんほかのはー？\n → 他のイベントを教えるよ！\n\nあずみんメモー！\n → メモしたのが見えるよ！".replyMessage
  else
    return  event.message['text'].replyMessage
  end
end