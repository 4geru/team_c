require 'open-uri'
require 'nokogiri'

def rand_museum_genre
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
  genres[rand(genres.count-1)]
end

def asoview_genre(date="20170121")
  genre = [
    {:name => "空"},
    {:name => "川・滝"},
    {:name => "海"},
    {:name => "湖・池"},
    {:name => "山・自然"},
    {:name => "乗り物"},
    {:name => "観光・レジャー"},
    {:name => "スポーツ・フィットネス"},
    {:name => "雪"},
    {:name => "日本文化"},
    {:name => "サブカルチャー"},
    {:name => "テクノロジー"},
    {:name => "スポーツ・フィットネス"},
    {:name => "日本文化"},
    {:name => "料理・お酒"},
    {:name => "ものづくり・クラフト"},
    {:name => "花・ガーデニング"},
  ]
end

def param_encode(museum)
  string = ""
  f = false
  for key in museum.keys
    string += '&' if f == true
    string += key + '=' + museum[key]
    f = true
  end
  string
end

def param_decode(string)
  hash = {}
  string.split('&').map{|item| 
    item.split('=').to_s
    hash[item.split('=')[0]] = item.split('=')[1]
  }
  hash
end

def get_id(event)
  case event["type"]
  when "user"
    return event["userId"]
  when "group"
    return event["groupId"]
  when "room"
    return event["roomId"]
  else
    return "error"
  end
end

def destroy_bookmarks(channel_id)
  keeps = Keep.where(channel: channel_id).order("updated_at desc").map {|event|
    event.destroy
  }
end

def museum_datas(url = rand_museum_genre[:url])
  uri = URI.parse(url)
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
      res = {}
      res["title"]     = event.elements['Name'].text
      res["url"]       = event.attribute('href').to_s
      res["area"]      = event.elements['Venue/Area'].text
      res["body"]      = event.elements['Description'].text.gsub(/\n/, '').slice(0,59)
      res["address"]   = event.elements['Venue/Address'].text
      res["latitude"]  = event.elements['Latitude'].text
      res["longitude"] = event.elements['Longitude'].text
      array.push(res)
    end
    return array
  when Net::HTTPRedirection
    puts "Redirection: code=#{response.code} message=#{response.message}"
  else
    puts "HTTP ERROR: code=#{response.code} message=#{response.message}"
  end
  rescue IOError => e
    puts e.message
  rescue JSON::ParserError => e
    puts e.message
  rescue => e
    puts e.message
  end
end

def rand_asoview_genre
  genres = asoview_genre
    
  searchUrls = `curl "http://www.asoview.com/search/?ymd=2017-01-21&rg=rgn04&pr=&ct=&np=&q=&bd=&targetAge=&timeRequired=" | grep searchUrl`
  facets = `curl "http://www.asoview.com/search/?ymd=2017-01-21&rg=rgn04&pr=&ct=&np=&q=&bd=&targetAge=&timeRequired=" | grep facet`

  facets = facets.split(',')
  searchUrls = searchUrls.split(',')
  puts facets.count-8
  puts genres.count
  for i in 8...facets.count-1
    count = facets[i].split("\'")[1].to_i
    if count > 4
      genres[i-8][:count] = count
      genres[i-8][:url]   = searchUrls[i].split("\'")[1]
    end 
  end
  genres[rand(genres.count-1)]
end

def get_asoview_data(datas,data)
  hash = {}
  max = data[:count].to_i

  (0..max/20).map{|i| hash[i] = [] }
  datas.map{|i| hash[i/20].push(i) }

  response = []
  for i in hash.keys
    if hash[i].count != 0
      url = "http://www.asoview.com/" + data[:url] + "&page=#{i+1}"
      puts url
      charset = nil
      html = open(url) do |f|
        charset = f.charset # 文字種別を取得
        f.read # htmlを読み込んで変数htmlに渡す
      end

      # htmlをパース(解析)してオブジェクトを生成
      doc = Nokogiri::HTML.parse(html, nil, charset)

      # タイトルを表示
      for j in hash[i]
        res = {}
        article = doc.xpath("//li[@class='plan-summary-list__item js-prAd_impression']")[j-i*20]
        res['title'] = article.xpath("//a[@class='plan-summary-list__plan-title-link js-prAd_click']")[j-i*20].inner_text
        res['url'] = "http://www.asoview.com/" + article.xpath("//a[@class='plan-summary-list__plan-title-link js-prAd_click']")[j-i*20][:href]
        res['body'] =  article.xpath("//p[@class='plan-summary-list__plan-description']").inner_text.slice(0,40)
        res['address'] = article.xpath("//p[@class='plan-summary-list__access-address']")[j-i*20].inner_text
        response.push(res)
      end
    end
  end
  response
end