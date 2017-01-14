def event_template(title, location, fee, body, image, num)
  message = {
    type: "template",
    altText: "this is a xarousel template",
    template: {
      type: "carousel",
      columns: [
        for i in 0..num
          {
            thumbnailImageUrl: image[i],
            title: title[i],
            text: location[i],
            text: fee[i],
            text: body[i],
            actions: [
              {
                type: "postback",
                label: "OK",
                data: "action=hoge",
              },
              {
                type: "postback",
                label: "detail",
                data: "action=hoge",
              },
              {
                type: "postback",
                label: "post",
                data: "action=hoge",
              }
            ]
          }
        end
       ]
    }
  }
end
