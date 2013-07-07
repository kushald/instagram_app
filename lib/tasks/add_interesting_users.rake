require 'request'
require 'json'
instagram_access_token = "415290916.f69d548.db7ce1275db54c9fa60bd5e76713d6f4"
task :add_interesting_users => :environment do
    interesting_ig_ids = ["6860189", "11830955", "25945306", "20979117", "19372645", "5560422", "4701871", 
                          "7924810", "50848923", "4870920", "175228882", "12223257", "14057957", "18370763",
                          "18428658", "6849281", "8326823", "14734199", "2720271", "18483678", "11305924", 
                          "179801071", "247650573", "20822623", "1706898", "1982097", "6773456", "28182428",
                          "40949744", "12246775", "21193118", "15347977", "11904202"
                        ]
    interesting_ig_ids.each do |id|
      data = Request.get_request("https://api.instagram.com/v1/users/#{id}/?access_token=#{instagram_access_token}")["data"]
      InterestingUser.create!(:instagram_user_id => data["id"],
                             :instagram_profile_picture => data["profile_picture"],
                             :instagram_username => data["username"], :category_type => 2)
      puts "====================================ADDED #{data["username"]}"
      sleep 10
    end
end

task :update_interesting_users => :environment do
  ctype = ENV['ctype'].to_i
  InterestingUser.where(:category_type => ctype).each do |u|
    p u.instagram_user_id
    data = Request.get_request("https://api.instagram.com/v1/users/#{u.instagram_user_id}/?access_token=#{instagram_access_token}")["data"]
    u.update_attributes(:instagram_user_id => data["id"],
                             :instagram_profile_picture => data["profile_picture"],
                             :instagram_username => data["username"], :category_type => ctype)
  end
end

task :get_instagram_user_id => :environment do 
  ig_usernames = [
                  "haileesteinfeld", "cash_warren", "abbiecornish", "howuseeit", "britneyspears", "50cent",
                  "ginnygoodwin", "chrishemsworth", "harrystyles", "itsludacris"
                 ].uniq
                 p ig_usernames.count
  ig_usernames_2 = [ 
                    "tonyhawk", "almond_surfboards","wimbledon", "snoopdogg", "wearephoenix", "madonna", "karliekloss", 
                    "burberry", "jamieoliver","vervecoffee", "shaym", "jimmyfallon", "charitywater", "fosterhunting", "petehalvorsen", 
                    "khiesti",
                    "awnoom", "diawdd", "woody_chai", "zcongklod", "phloemstudio", "dannybones64", "neji_maki_dori",
                    "aiww", "vikmuniz", "jr", "marcquinnart", "tomsachs", "moscerina", "nasyakopteva", "patrickwitty",
                    "missunderground", "melkadel", "jgboyer", "technopaul", "kamilsharaidin", "farrahallan", "stephanie_somebody",
                    "cleocoppinger", "Katia_mi", "saturday", "joshuabgeyer", "ravivora", "emilycall", "brahmino", "johnkeatley"
                   ] 
  arr, ids = [], []
  ig_usernames.each do |user|
    p "=======================#{user}========================"
    id = Request.get_request("https://api.instagram.com/v1/users/search?q=#{user}&access_token=#{instagram_access_token}")["data"][0]["id"]
    arr << [user,id]
    ids << id
    sleep 20
    p "=========================#{id}========================"
  end
  ids
end