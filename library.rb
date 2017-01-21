def param_encode(data)
  string = ""
  f = false
  for key in data.keys
    string += '&' if f == true
    string += key + '=' + data[key]
    f = true
  end
  string
end

def param_decode(string)
  hash = {}
  string.split('&').map{|item| 
    hash[item.split('=')[0]] = item.split('=')[1]
  }
  hash
end

def get_id(event)
  case event["type"]
  when "user"
    return event["userId"]
  when "group"
    return event["groupId"]
  when "room"
    return event["roomId"]
  else
    return "error"
  end
end

def destroy_memos(channel_id)
  Keep.where({channel: channel_id}).delete_all
end

def destroy_memo(channel_id,json=nil)
  json = param_decode(json)
  json['type'] = 'keep'
  Keep.where({channel: channel_id, json: param_encode(json)}).delete_all
end

def make_action_url(url)
  {
    "type": "uri",
    "label": "詳しく見る",
    "uri": url
  }
end

def make_action_address(gps)
  {
    "type": "postback",
    "label": "場所を見る",
    "data": gps
  }
end

def make_action_memo(data)
  {
    "type": "postback",
    "label": "メモする",
    "text": data["title"] + ' をメモったよ！',
    "data": param_encode(data)
  }
end

def make_action_destroy(data)
  {
    "type": "postback",
    "label": "削除",
    "text": data["title"] + ' 削除したよ！！',
    "data": param_encode(data)
  }
end