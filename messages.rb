require 'net/http'
require 'uri'
require 'json'
require "rexml/document" 

def reply_message(message='')
	message = {
    type: 'text',
    text: message
  }
end

def reply_carousel_museums(museums)
	puts museums[0]
	puts museums[1]
	puts museums[2]
	puts museums[3]
	puts museums[4]
{
  "type": "template",
  "altText": "this is a carousel template",
  "template": {
      "type": "carousel",
      "columns": [
        hoge(museums[0]),
       	hoge(museums[1]),
       	hoge(museums[2]),
        hoge(museums[3]),
       	hoge(museums[4])
      ]
  }
}
end
def hoge(museum)
	{
		"thumbnailImageUrl": "https://example.com/bot/images/item1.jpg",
    "title": museum["title"] + ' ' + museum["area"],
	  "text": museum["body"],
	  "actions": [
      {
        "type": "uri",
		    "label": "詳しく",
	  	  "uri": museum["url"]
      }
    ]
  }
end

def reply_template_museum(museum)
	{
	  "type": "template",
	  "altText": "this is a buttons template",
	  "template": {
	      "type": "buttons",
	      "thumbnailImageUrl": "https://example.com/bot/images/image.jpg",
	      "title": museum["title"] + ' ' + museum["area"],
	      "text": museum["body"],
	      "actions": [
	          {
	            "type": "uri",
	            "label": "詳しく",
	            "uri": museum["url"]
	          }
	      ]
	  }
	}
end

def reply_museum_datas
	uri = URI.parse("http://www.tokyoartbeat.com/list/event_type_print_illustration.ja.xml")
	begin
	  response = Net::HTTP.start(uri.host) do |http|
	    http.get(uri.request_uri)
	  end
	  puts 'get response'
	  case response
	  when Net::HTTPSuccess
	  	doc = REXML::Document.new(response.body)
	  	array = []
	  	doc.elements.each('Events/Event') do |event|
#	  	doc.elements['Events'].each do |event|
		  	res = {}
		  	res["title"] = event.elements['Name'].text
		  	res["url"]   = event.attribute('href').to_s
		  	res["area"]  = event.elements['Venue/Area'].text
		  	res["body"]  = event.elements['Description'].text.slice(0,60)
		  	array.push(res)
		 	end
		  puts array.count
	  	return array
	  when Net::HTTPRedirection
	  	puts 'warn'
	    logger.warn("Redirection: code=#{response.code} message=#{response.message}")
	  else
	  	puts 'error'
	    logger.error("HTTP ERROR: code=#{response.code} message=#{response.message}")
	  end
	rescue IOError => e
		puts e.message
	rescue JSON::ParserError => e
		puts e.message
	rescue => e
		puts e.message
	end
end

def reply_museum_data
	uri = URI.parse("http://www.tokyoartbeat.com/list/event_type_print_illustration.ja.xml")
	begin
	  response = Net::HTTP.start(uri.host) do |http|
	    http.get(uri.request_uri)
	  end
	  puts 'get response'
	  case response
	  when Net::HTTPSuccess
	  	doc = REXML::Document.new(response.body)
		  puts 'move'
	   	res = {}
		  res["title"] = doc.elements['Events/Event/Name'].text
		 	res["url"]   = doc.elements['Events/Event'].attribute('href').to_s
		 	res["area"]  = doc.elements['Events/Event/Venue/Area'].text
	  	res["body"]  = doc.elements['Events/Event/Description'].text.slice(0,60)
	  	return res
	  when Net::HTTPRedirection
	  	puts 'warn'
	    logger.warn("Redirection: code=#{response.code} message=#{response.message}")
	  else
	  	puts 'error'
	    logger.error("HTTP ERROR: code=#{response.code} message=#{response.message}")
	  end
	rescue IOError => e
		puts e.message
	rescue JSON::ParserError => e
		puts e.message
	rescue => e
		puts e.message
	end
end