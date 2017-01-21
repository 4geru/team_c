def param_encode(string)
  string = ""
  f = false
  for key in string.keys
    string += '&' if f == true
    string += key + '=' + string[key]
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

def destroy_bookmarks(channel_id)
  keeps = Keep.where(channel: channel_id).order("updated_at desc").map {|event|
    event.destroy
  }
end