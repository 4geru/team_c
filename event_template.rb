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
            "text": "body",
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
          }
      ]
  }
}
end
#def event_template(title, location, fee, body, image, num)
=begin
def art_template
  {
    "type": "template",
    "altText": "this is a carousel template",
    "template": {
      "type": "carousel",
      "columns": [
#        art.colum
        {
          "thumbnailImageUrl": "http://example.com/bot/images/item1.jpg",#art[4],
          "title": "title",#art[0],
          "text": "location",#art[1],
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
          "thumbnailImageUrl": "http://example.com/bot/images/item1.jpg",#art[4],
          "title": "title",#art[0],
          "text": "location",#art[1],
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
        }
       ]
    }
  }
end
=begin
class Art
  attr_accessor :title , :location, :fee, :body, :image

  def set(title:, location:, fee:, body:, image:)
    self.title = title
    self.location = location
    self.fee = fee
    self.image = image
  end

  def colum
    {
      "thumbnailImageUrl": self.image,
      "title": self.title,
      "text": self.location,
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
    }
  end
end
=end
