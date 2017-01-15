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

def reply_template_museum(data)
	{
	  "type": "template",
	  "altText": "this is a buttons template",
	  "template": {
	      "type": "buttons",
	      "thumbnailImageUrl": "https://example.com/bot/images/image.jpg",
	      "title": data["title"] + ' ' + data["area"],
	      "text": data["body"],
	      "actions": [
	          {
	            "type": "uri",
	            "label": "詳しく",
	            "uri": "http://example.com/page/123"
	          }
	      ]
	  }
	}
end

def reply_data
	uri = URI.parse("http://www.tokyoartbeat.com/list/event_type_print_illustration.ja.xml")
	begin
	  response = Net::HTTP.start(uri.host) do |http|
	    http.get(uri.request_uri)
	  end
	  puts 'get response'
	  case response
	  when Net::HTTPSuccess
	  	doc = REXML::Document.new(response.body)
	  	event = doc.elements['Events']
	  	res = {}
	  	res["title"] = event.elements['Event/Name'].text
	  	res["url"]   = event.elements['Event'].attribute('href').to_s
	  	res["area"]  = event.elements['Event/Venue/Area'].text
	  	res["body"]  =  event.elements['Event/Description'].text.slice(0,60)
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