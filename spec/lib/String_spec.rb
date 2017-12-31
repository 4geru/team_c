require 'spec_helper'

describe String do

  describe 'hello objectを返す' do
    it { expect("hello".replyMessage).to eq ({ :type => 'text', :text => 'hello' }) }
  end
end