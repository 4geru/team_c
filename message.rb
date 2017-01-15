require './rand_message'
def reply_rand_genre
	message = {
	  type: 'text',
	  text: rand_genre + " はいかがでしょうか？"
	}
end

def reply_template
<<<<<<< HEAD
{
  "type": "template",
  "altText": "this is a carousel template",
  "template": {
      "type": "carousel",
      "columns": [
          {
            "thumbnailImageUrl": "https://example.com/bot/images/item1.jpg",
            "title": "this is menu",
            "text": "description",
            "actions": [
                {
                    "type": "postback",
                    "label": "Buy",
                    "data": "action=buy&itemid=111"
                },
                {
                    "type": "postback",
                    "label": "Add to cart",
                    "data": "action=add&itemid=111"
                },
                {
                    "type": "uri",
                    "label": "View detail",
                    "uri": "http://example.com/page/111"
                }
            ]
          },
          {
            "thumbnailImageUrl": "https://example.com/bot/images/item2.jpg",
            "title": "this is menu",
            "text": "description",
            "actions": [
                {
                    "type": "postback",
                    "label": "Buy",
                    "data": "action=buy&itemid=222"
                },
                {
                    "type": "postback",
                    "label": "Add to cart",
                    "data": "action=add&itemid=222"
                },
                {
                    "type": "uri",
                    "label": "View detail",
                    "uri": "http://example.com/page/222"
                }
            ]
          }
      ]
  }
}
end

def carousel_columns(category, page)
	contents = {
		"thumbnailImageUrl": "https://example.com/bot/images/item1.jpg",
		"title": "title",
		"text": "body" + "\n場所 : " + "location" + " / 料金 : " + "fee",
		"actions": [
				{
						"type": "postback",
						"label": "ここに行く",
						"data": "action=buy&itemid=111"
						"text": "「" + "title" + "」に行きたい"
				},
				{
						"type": "postback",
						"label": "キープする",
						"data": "action=add&itemid=111"
				},
				{
						"type": "uri",
						"label": "くわしく見る",
						"uri": "http://www.tokyoartbeat.com/event/2016/E29C"
				}
			]
		}
		return contents
end

def reply_carousel(category, page)
  {
    "type": "template",
    "altText": "this is a carousel template",
    "template": {
        "type": "carousel",
        "columns": [
#					carousel_columns(category, page),
#					carousel_columns(category, page+1),
#					carousel_columns(category, page+2),
#					carousel_columns(category, page+3).
#					carousel_columns(category, page+4)
        ]
    }
  }
end
=======
	 {
	  "type": "template",
	  "altText": "this is a carousel template",
	  "template": {
	      "type": "carousel",
	      "columns": [
	          {
	            "thumbnailImageUrl": "https://example.com/bot/images/item1.jpg",
	            "title": "this is menu",
	            "text": "description",
	            "actions": [
	                {
	                    "type": "postback",
	                    "label": "Buy",
	                    "data": "action=buy&itemid=111"
	                },
	                {
	                    "type": "postback",
	                    "label": "Add to cart",
	                    "data": "action=add&itemid=111"
	                },
	                {
	                    "type": "uri",
	                    "label": "View detail",
	                    "uri": "http://example.com/page/111"
	                }
	            ]
	          },
	          {
	            "thumbnailImageUrl": "https://example.com/bot/images/item2.jpg",
	            "title": "this is menu",
	            "text": "description",
	            "actions": [
	                {
	                    "type": "postback",
	                    "label": "Buy",
	                    "data": "action=buy&itemid=222"
	                },
	                {
	                    "type": "postback",
	                    "label": "Add to cart",
	                    "data": "action=add&itemid=222"
	                },
	                {
	                    "type": "uri",
	                    "label": "View detail",
	                    "uri": "http://example.com/page/222"
	                }
	            ]
	          }
	      ]
	  }
	}
end

def reply_message(message)
	message = {
	  type: 'text',
	  text: message
	}
end
>>>>>>> 700d8c8185a557f7620638dc8b8f44480ffc7336
