#def event_template(title, location, fee, body, image, num)
def event_template
  {
=begin
    "type": "template",
    "altText": "this is a carousel template",
    "template": {
      "type": "carousel",
      "columns": [
        #for i in 0..num
          {
            "thumbnailImageUrl": "image",
            "title": "title",
            "text": "location",
#            "text": fee[i],
#            "text": body[i],

            "actions": [
              {
                "type": "postback",
                "label": "OK",
                "data": "action=hoge",
              },
              {
                "type": "postback",
                "label": "detail",
                "data": "action=hoge",
              },
              {
                "type": "postback",
                "label": "post",
                "data": "action=hoge",
              }
            ]

          }
        #end
       ]
    }
=end

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
