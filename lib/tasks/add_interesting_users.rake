require 'request'
require 'json'
instagram_access_token = "415290916.f69d548.db7ce1275db54c9fa60bd5e76713d6f4"
task :add_interesting_users => :environment do
    interesting_ig_ids = [
                          "345177", "202381785", "343112610", "303107039", "14935933", "18964411", "262832825",
                          "3491139", "55566040", "25427848", "1132845", "16593933", "186007764", "1574083", 
                          "356510111", "181306552", "10581097", "1889387", "3532778", "7949770", "2364270", 
                          "28473942", "1591667", "1504627", "1809965", "6606118", "322980", "6471303", "2430352",
                          "1636888", "20982320", "19176201", "51545494", "7747574", "9271963", "17789355", "243374869",
                          "214714394", "1991637", "7213412", "51322110", "1891003", "5898164", "12479544", "1016340", 
                          "27065219", "14333234", "3283671", "22921132", "25016632", "1286836", "30920826", "95982", 
                          "31512920", "1918184", "293994998"
                         ]
    interesting_ig_ids.each do |id|
      data = Request.get_request("https://api.instagram.com/v1/users/#{id}/?access_token=#{instagram_access_token}")["data"]
      InterestingUser.create!(:instagram_user_id => data["id"],
                             :instagram_profile_picture => data["profile_picture"],
                             :instagram_username => data["username"])
      puts "====================================ADDED #{data["username"]}"
      sleep 60
    end
end

task :get_instagram_user_id => :environment do 
  ig_usernames = [
                  "yokokaku", "rccam", "disneyland", "sixflags", "cedarpoint", "kelseybrookes",
                  "steveespopowers", "lolagil", "dannybeck1", "benvenom",
                 ]
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
    id = Request.get_request("https://api.instagram.com/v1/users/search?q=#{user}&access_token=#{instagram_access_token}")["data"][0]["id"]
    arr << [user,id]
    ids << id
  end
  p ids.inspect
end