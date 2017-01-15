def art_template(title, location, fee, body, image)
{
  "type": "template",
  "altText": "this is a carousel template",
  "template": {
      "type": "carousel",
      "columns": [
          {
            "thumbnailImageUrl": "https://example.com/bot/images/item1.jpg",
            "title": title,
            "text": body + "\n場所 : " + location + " / 料金" + fee,
            "actions": [
                {
                    "type": "postback",
                    "label": "ここに行く",
                    "data": "action=buy&itemid=111"
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
      ]
  }
}
end