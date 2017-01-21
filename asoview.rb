require 'open-uri'
require 'nokogiri'

def asoview_genre
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
    {:name => "cannot find"},
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

def rand_asoview_genre(date="2017-01-21")
  genres = asoview_genre
    
  searchUrls = `curl "http://www.asoview.com/search/?ymd=2017-01-28&rg=rgn04&pr=&ct=&np=&q=&bd=&targetAge=&timeRequired=" | grep searchUrl`
  facets = `curl "http://www.asoview.com/search/?ymd=2017-01-28&rg=rgn04&pr=&ct=&np=&q=&bd=&targetAge=&timeRequired=" | grep facet`
  puts facets
  facets = facets.split(',')
  searchUrls = searchUrls.split(',')
  over_5_events = []
  genre_index = 0
  for i in 1...searchUrls.count-1
    count = facets[i].split('\'')[1].to_i
    if not searchUrls[i] =~ /prf/ and count > 4
      d = param_decode(searchUrls[i].split('?')[1])
      genre = genres[d['ct'].to_i-1]
      searchUrl = searchUrls[i].split('\'')[1]
      genre[:url] = searchUrl
      genre[:count] = count
      puts genre
      over_5_events.push(genre)
    end
  end
  puts over_5_events
  over_5_events[rand(over_5_events.count-1).to_i]
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
        res['address'] = article.xpath("//p[@class='plan-summary-list__access-address']")[j-i*20].inner_text || "見つかりませんでした"
        response.push(res)
      end
    end
  end
  response
end

def reply_carousel_asoview(asoview_data)
  randoms = (0...asoview_data[:count]).to_a.shuffle![0...5]
  datas = get_asoview_data(randoms.sort, asoview_data)
  datas.map!{|data| make_carousel_asoview_cloumns(data) }
  {
    "type": "template",
    "altText": "this is a carousel template",
    "template": {
       "type": "carousel",
       "columns": datas
    }
  }
end

def make_carousel_asoview_cloumns(data)
  puts data
  data["source_page"] = 'asoview'
  keep = data.dup
  keep["type"] = 'keep'
  gps = data.dup
  gps["type"] = 'gps'
  puts keep
  puts gps
  {
    "thumbnailImageUrl": "https://res.cloudinary.com/dn8dt0pep/image/upload/v1484641224/question.jpg",
    "title": data["title"].slice(0,40),
    "text": data["body"],
    "actions": [
      {
        "type": "uri",
        "label": "詳しく見る",
        "uri": data["url"]
      },
      {
        "type": "postback",
        "label": "場所を見る",
        "data": param_encode(gps)
      },
      {
        "type": "postback",
        "label": "メモする",
        "text": data["title"] + ' をメモったよ！',
        "data": param_encode(keep)
      }
    ]
  }
end