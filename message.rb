require './rand_message'

def reply_rand_genre
	message = {
	  type: 'text',
	  text: rand_genre + " 系はいかがでしょうか？"
	}
end

def reply_template
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

def reply_template_date
	{
	  "type": "template",
	  "altText": "this is a buttons template",
	  "template": {
	      "type": "buttons",
	      "thumbnailImageUrl": "",
	      "title": "いつ頃がいいですか？",
	      "text": "",
	      "actions": [
	          {
	            "type": "今日",
	            "label": "Buy",
	            "data": ""
	          },
	          {
	            "type": "明日",
	            "label": "Add to cart",
	            "data": ""
	          },
	          {
	            "type": "週末",
	            "label": "View detail",
	            "uri": ""
	          }
	      ]
	  }
	}
end