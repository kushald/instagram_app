task :interesting_users_posts => :environment do
  #interesting_users = InterestingUser.all.collect(&:instagram_user_id)
  instagram_access_token = User.find(2).instagram_access_token
  puts interesting_users
  interesting_users.each do |id|
    data = Request.get_request("https://api.instagram.com/v1/users/#{id}/media/recent/?access_token=#{instagram_access_token}")
    #data["data"][0..9].each {|d| p d["images"]["low_resolution"]["url"]; p d['id']; p id}
    data["data"][0..9].each do |d|
      InterestingUserPost.create!(:instagram_user_id => id,
                                  :media_id => d['id'],
                                  :image_standard => d["images"]["standard_resolution"]["url"],
                                  :image_low => d["images"]["low_resolution"]["url"])
    end
    puts "==========================id #{id} entry created"
    sleep 60
  end
end 

task :update_interesting_user_posts => :environment do 
  instagram_access_token = User.find(1).instagram_access_token
  interesting_users = InterestingUser.where("category_type = 1").collect(&:instagram_user_id)
  p interesting_users.inspect
  data = NIL
  interesting_users.each do |id|
  begin
    delete_ids = InterestingUserPost.where(:instagram_user_id => id).collect(&:id)
    puts "-------------------------------------------#{id}"
    status = Timeout::timeout(20) {
      data = Request.get_request("https://api.instagram.com/v1/users/#{id}/media/recent/?access_token=#{instagram_access_token}&count=3")
    }
    rescue Timeout::Error
      puts 'EXEPTION...'
    end
    data["data"][0..1].each do |d|
      InterestingUserPost.create!(:instagram_user_id => id,
                                  :media_id => d['id'],
                                  :image_standard => d["images"]["standard_resolution"]["url"],
                                  :image_low => d["images"]["low_resolution"]["url"],
                                  :thumb_image => d["images"]["thumbnail"]["url"])
      puts "----------------------post for id #{id} created"
     end
    InterestingUserPost.where(:id => delete_ids).delete_all  
    sleep 2
  end
  puts "++++++++++++++++++++++++++++++#{Time.now}+++++++++++++++++++++++++++++++++++++++++++++++++"
end

desc "Define secret token"
task :define_secret_token => :environment do
  require 'yaml'
  path = ENV['path']
  config_yml = YAML.load(File.open(path))
  config_yml["production"]["client_secret"] = ENV['sk']
  config_yml["production"]["fb_app_id"] = ENV['fbid']
  File.open(path, "w") {|f| f.write(config_yml.to_yaml) }
end