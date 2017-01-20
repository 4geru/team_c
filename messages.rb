require 'net/http'
require 'uri'
require 'json'
require "rexml/document" 
require './library'

# "デバッグ用"
def reply_message(message='')
  message = {
    type: 'text',
    text: message
  }
end

# "あずみん起きて"
def reply_confirm_start
  {
    "type": "template",
    "altText": "this is a confirm template",
    "template": {
      "type": "confirm",
      "text": "おはよう\nイベント行きたいの？",
      "actions": [
        {
          "type": "postback",
          "label": "行きたい！",
          "text": "行きたい！",
          "data": "行きたい"
        },
        {
          "type": "postback",
          "label": "呼んだだけ",
          "text": "呼んだだけ",
          "data": "呼んだだけ"
        }
      ]
    }
  }
end

# "行きたい！" 日程選択
def reply_botton_schedule
  {
    "type": "template",
    "altText": "this is a buttons template",
    "template": {
      "type": "buttons",
      "thumbnailImageUrl": "https://res.cloudinary.com/dn8dt0pep/image/upload/v1484641224/question.jpg",
      "title": "日程決めるよ",
      "text": "いつがいい？",
      "actions": [
        {
          "type": "postback",
          "label": "今日",
          "text": "今日行きたい",
          "data": "今日だね"
        },
        {
          "type": "postback",
          "label": "明日",
          "text": "明日行きたい",
          "data": "明日だね"
        },
        {
          "type": "postback",
          "label": "週末",
          "text": "週末行きたい",
          "data": "週末だね"
        },
        {
          "type": "postback",
          "label": "決まってない",
          "text": "決まってない",
          "data": "決まっていない"
        }
      ]
    }
  }
end

def reply_carousel_museums(museums)
  randoms = (0...museums.count).to_a.shuffle![0...5]
  randoms.map!{|item| make_carousel_museum_cloumns(museums[item])}
  {
    "type": "template",
    "altText": "this is a carousel template",
    "template": {
       "type": "carousel",
       "columns": randoms
    }
  }
end

def reply_carousel_bookmarks(channel='')
  keeps = Keep.where(channel: channel).
    order("updated_at desc").limit(5).map {|event|
    	data =  param_decode(event['json'])
    	if data['source_page'] == 'museum'
	      make_carousel_museum_cloumns(data)
  		else
  			make_carousel_asoview_cloumns(data)
  		end
  }
  if keeps.count == 0
  	reply_message("まだブックマークされてないよー！")
  else
    {
      "type": "template",
      "altText": "this is a carousel template",
      "template": {
        "type": "carousel",
        "columns": keeps
      }
    }
  end 
end

def make_carousel_museum_cloumns(museum)
  museum["source_page"] = 'museum'
  keep = museum.dup
  keep["type"] = 'keep'
  gps = museum.dup
  gps["type"] = 'gps'
  {
    "thumbnailImageUrl": "https://res.cloudinary.com/dn8dt0pep/image/upload/v1484641224/question.jpg",
    "title": museum["title"].slice(0,40-museum["area"].size-1) + '/' + museum["area"],
    "text": museum["body"],
    "actions": [
      {
        "type": "uri",
        "label": "詳しく見る",
        "uri": museum["url"]
      },
      {
        "type": "postback",
        "label": "場所を見る",
        "data": param_encode(gps)
      },
      {
        "type": "postback",
        "label": "ブックマークする",
        "text": museum["title"] + ' をブックマークしました',
        "data": param_encode(keep)
      }
    ]
  }
end


def reply_carousel_asoview(asoview_data)
  randoms = (0...asoview_data[:count]).to_a.shuffle![0...5]
  datas = get_asoview_data(randoms.sort, asoview_data)
  datas.map!{|data| make_carousel_asoview_cloumns(data) }
  {
    "type": "template",
    "altText": "this is a carousel template",
    "template": {
       "type": "carousel",
       "columns": datas
    }
  }
end

def make_carousel_asoview_cloumns(data)
  data["source_page"] = 'asoview'
  keep = data.dup
  keep["type"] = 'keep'
  gps = data.dup
  gps["type"] = 'gps'
  {
    "thumbnailImageUrl": "https://res.cloudinary.com/dn8dt0pep/image/upload/v1484641224/question.jpg",
    "title": data["title"].slice(0,40),
    "text": data["body"],
    "actions": [
      {
        "type": "uri",
        "label": "詳しく見る",
        "uri": data["url"]
      },
      {
        "type": "postback",
        "label": "場所を見る",
        "data": param_encode(gps)
      },
      {
        "type": "postback",
        "label": "ブックマークする",
        "text": data["title"] + ' をブックマークしました',
        "data": param_encode(keep)
      }
    ]
  }
end
def reply_gps(title='',address='',latitude='',longitude='')
  {
    "type": "location",
    "title": title,
    "address": address,
    "latitude": latitude,
    "longitude": longitude
  }
end