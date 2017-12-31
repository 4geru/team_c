class Action
  def initialize(type, option = {})
    @type = type
    @option = option
  end

  def getType
    @type
  end
  
  # {:label => string, :text => string, :data => {} }
  def postback
    {
      :type => @type,
      :label => @option[:label],
      :text => @option[:text],
      :data => param_encode(@option[:data])
    }
  end

  def uri
    {
      :type => @type,
      :label => @option[:label],
      :text => @option[:text],
      :uri => @option[:uri]
    }
  end

  def param_encode(data)
    string = ''
    f = false
    for key in data.keys
      string += '&' if f == true
      string += key.to_s + '=' + data[key]
      f = true
    end
    string
  end
end