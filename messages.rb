def reply_message(message='')
	message = {
    type: 'text',
    text: message
  }
end

def reply_data
	uri = URI.parse("http://www.tokyoartbeat.com/list/event_type_print_illustration.ja.xml")
	begin
	  response = Net::HTTP.start(uri.host) do |http|
	    http.get(uri.request_uri)
	  end

	  case response
	  when Net::HTTPSuccess
	  	doc = REXML::Document.new(response.body)
	  	res = doc.class
	  	res += "URL #{doc.elements['Events/Event'].attribute('href')}\n"
	  	res += "Name #{doc.elements['Events/Event/Name'].text}\n"
	  	res += "Adress #{doc.elements['Events/Event/Venue/Address'].text}\n"
	  	res += "Area #{doc.elements['Events/Event/Venue/Area'].text}\n"
	  	res += "Description #{doc.elements['Events/Event/Description'].text.slice(0,60)}\n"
			return res
	  when Net::HTTPRedirection
	    logger.warn("Redirection: code=#{response.code} message=#{response.message}")
	  else
	    logger.error("HTTP ERROR: code=#{response.code} message=#{response.message}")
	  end
	rescue IOError => e
		logger.error(e.message)
	rescue JSON::ParserError => e
		logger.error(e.message)
	rescue => e
		logger.error(e.message)
	end
end