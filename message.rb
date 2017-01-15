require './rand_message'
def reply_rand_genre
	message = {
	  type: 'text',
	  text: rand_genre + " はいかがでしょうか？"
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