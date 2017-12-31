require 'spec_helper'

describe Action do
  describe 'postback typeを返す' do
    action = Action.new('type')
    it { expect(action.getType).to eq ('type') }
  end

  describe 'postback actionを返す' do
    action = Action.new('postback', {
      :label => 'label',
      :text => 'text',
      :data => {:a => 'b', :c => 'd'}
    })
    obj = {
      :type => 'postback',
      :label => 'label',
      :text => 'text',
      :data => 'a=b&c=d'
    }
    it { expect(action.postback).to eq (obj) }
  end

  describe 'uri actionを返す' do
    action = Action.new('uri', {
      :label => 'label',
      :text => 'text',
      :uri => 'http://example.com'
    })
    obj = {
      :type => 'uri',
      :label => 'label',
      :text => 'text',
      :uri => 'http://example.com'
    }
    it { expect(action.uri).to eq (obj) }
  end

end