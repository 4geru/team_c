class String
  def replyMessage
    { :type => 'text', :text => self }
  end
end