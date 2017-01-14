#def event_template(title, location, fee, body, image, num)
def event_template
  {
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
=begin
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
=end
          }
        #end
       ]
    }
  }
end
