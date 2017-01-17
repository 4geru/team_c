require "sinatra"
require 'sinatra/activerecord'
require 'sinatra/activerecord/rake'

# db モデルファイルの読み込み
require './models/keeps.rb'

# puts デバッグのやつ
$stdout.sync = true

# rake task fileの読み込み
Dir.glob('lib/tasks/*.rake').each { |r| load r}