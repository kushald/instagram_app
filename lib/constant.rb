module Constant
  HOST = 'api.instagram.com'
  ENDPOINT = 'https://api.instagram.com/v1/'.freeze
  POPULAR = "https://api.instagram.com/v1/media/popular/".freeze
  FEED = "https://api.instagram.com/v1/users/self/feed/".freeze
  GUEST_IDS = ["415290916","451906530","539573072"]
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
end