module Constant
  HOST = 'api.instagram.com'
  ENDPOINT = 'https://api.instagram.com/v1/'.freeze
  POPULAR = "https://api.instagram.com/v1/media/popular/".freeze
  FEED = "https://api.instagram.com/v1/users/self/feed/".freeze
  GUEST_IDS = ["1419904750", "1419921419", "1419929197", "1419934670"]
  POPULAR_HASHTAGS = ["love","instagood", 'me', 'cute', 'tbt', 'eyes', 'statigram', 'throwbackthursday',
                      'photooftheday', 'nice', 'follow', 'beautiful', 'happy', 'all_shots', 'harrystyles',
                      'girl', 'instamood', 'picoftheday', 'instadaily', 'niallhoran', 'instago', 'igers',
                      'jj_forum', 'like', 'followme', 'fashion', 'fun', 'smile', 'bestoftheday', 'iphonesia',
                      'summer', 'nofilter', 'food', 'friends', 'lol', 'sun', 'instagramhub', 'iphoneonly',
                      'sky', 'webstagram', 'pretty', 'picstitch', 'tweegram', 'my', 'hair', 'jj', 'bored',
                      'life', 'swag', 'cool', 'funny', 'igdaily', 'family', 'repost', 'photo', 'pink', 
                      'amazing', 'blue', 'girls', 'hot', 'baby', 'instagramers', 'black', 'art', 'instalove',
                      'zaynmalik', 'party', 'night', 'best', 'music'
                     ].freeze
  LOGIN_URL = "https://instagram.com/oauth/authorize/?client_id=#{APP_CONFIG['client_id']}&redirect_uri=#{APP_CONFIG['redirect_uri']}&response_type=code&scope=likes+comments+relationships".freeze
  FILTERS = [
              "Amaro", "Mayfair", "Rise", "Valencia", "Hudson", "XProII", "Sierra",
              "Willow", "Lofi", "Earlybird", "Sutro", "Toaster", "Brannan", "Inkwell",
              "Walden", "Hefe", "Nashville", "1977", "Kelvin"
              ].freeze

  AUTHORIZED_IDS = ["52093116"]
  COUNT = 10
  TEMP_SHOP_BRANDS = ["americanapparelusa", "americaneagle", "ralphlauren", "prada", "armani", "puma", "reebokclassics",
                       "gap", "dolcegabbanaofficial", "dcshoes", "ripcurl_usa", "tommyhilfiger", "freshtops",
                      "nike", "adidasoriginals", "converse", "forever21", "topshop", "vans", "victoriassecret", "michaelkors",
                      "hm", "gucci", "hollisterco", "louisvuitton", "burberry", "asos", "levis", "versace_official", "hugoboss",
                      "modcloth", "rayban","mangofashion" 
                     ]

  EXCLUDE_USER_IDS = ["361460824", "179293483", "509794020", "27014377", "250566440", "376601127", "30768248", "4350221", 
                      "182884386", "223901729", "36476395", "180298319", "145529320", "425907745", "31151546", "395561010", "474351359", "227208888"]
  EXCLUDE_USER_NAMES = ["helloojaclyn", "im5xoxo", "akshaykharb", "gkriebel9899", "myajeannine", "jessimicablaze",
                        "sofieaaboe96", "jamieleecreations", "jacicutiee", "hugoblc", "janatovalovich_art", "cameliasaltos",
                        "valeryparadise", "mrskenpachi", "deandale_balana","elenaflyaway", "talie43", "bodyelevatedfit", "erro_ldn"]

  TEMP_TOP_BRANDS = [
                      {:display => "American Apparel USA", :url => "americanapparelusa"},
                      {:display => "American Eagle", :url => "americaneagle"},
                      {:display => "Victorias Secret", :url => "victoriassecret"},
                      {:display => "Gap", :url => "gap"},
                      {:display => "Converse", :url => "converse"},
                      {:display => "Armani", :url => "armani"},
                      {:display => "Ralph Lauren", :url => "ralphlauren"},
                      {:display => "Puma", :url => "puma"},
                      {:display => "Fresh Tops", :url => "freshtops"},
                      {:display => "Vans", :url => "vans"}
                    ]
end