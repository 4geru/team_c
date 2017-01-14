require './models/genre.rb'
namespace :make do

  desc "It make Genre db"
  task :genre do
  	genres = [
  		{:name => "2D/イラスト", :url => "http://www.tokyoartbeat.com/list/event_type_print_illustration.ja.xml"},
  		{:name => "2D/デッサン", :url => "http://www.tokyoartbeat.com/list/event_type_print_drawing.ja.xml"},
  		{:name => "2D/グラフィックス", :url => "http://www.tokyoartbeat.com/list/event_type_print_graphicdesign.ja.xml"},
  		{:name => "2D/写真", :url => "http://www.tokyoartbeat.com/list/event_type_print_photo.ja.xml"},
  		{:name => "2D/版画", :url => "http://www.tokyoartbeat.com/list/event_type_print_prints.ja.xml"},
  		{:name => "2D/珍しい", :url => "http://www.tokyoartbeat.com/list/event_type_print_other.ja.xml"},
  	
  		{:name => "3D/建築", :url => "http://www.tokyoartbeat.com/list/event_type_3D_architecture.ja.xml"},
  		{:name => "3D/彫刻&立体", :url => "http://www.tokyoartbeat.com/list/event_type_3D_sculpture.ja.xml"},
  		{:name => "3D/工芸", :url => "http://www.tokyoartbeat.com/list/event_type_3D_crafts.ja.xml"},
  		{:name => "3D/ファッション", :url => "http://www.tokyoartbeat.com/list/event_type_3D_fashion.ja.xml"},
  		{:name => "3D/家具", :url => "http://www.tokyoartbeat.com/list/event_type_3D_furniture.ja.xml"},
  		{:name => "3D/インスタレーション", :url => "http://www.tokyoartbeat.com/list/event_type_3D_installation.ja.xml"},
  		{:name => "3D/プロダクト", :url => "http://www.tokyoartbeat.com/list/event_type_3D_productdesign.ja.xml"},
  		{:name => "3D/陶芸", :url => "http://www.tokyoartbeat.com/list/event_type_3D_ceramics.ja.xml"},
  		{:name => "3D/珍しい", :url => "http://www.tokyoartbeat.com/list/event_type_3D_other.ja.xml"},

  		{:name => "スクリーン/映画", :url => "http://www.tokyoartbeat.com/list/event_type_screen_film.ja.xml"},
  		{:name => "スクリーン/デジタル", :url => "http://www.tokyoartbeat.com/list/event_type_screen_digital.ja.xml"},

  		{:name => "パーティー", :url => "http://www.tokyoartbeat.com/list/event_type_misc_party.ja.xml"},
  		{:name => "トークイベント", :url => "http://www.tokyoartbeat.com/list/event_type_misc_talk.ja.xml"},
  		{:name => "パフォーマンスアート", :url => "http://www.tokyoartbeat.com/list/event_type_misc_performance.ja.xml"},
  		{:name => "一般公募", :url => "http://www.tokyoartbeat.com/list/event_type_misc_performance.ja.xml"},
  	]

  	genres.each do |t|
  		Genre.create(t).save
  	end
  	puts 'insert to genre db'
  end
end
