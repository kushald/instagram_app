task :interesting_users_posts => :environment do
  interesting_users = InterestingUser.all.collect(&:instagram_user_id)
  puts interesting_users
  instagram_access_token = "415290916.f69d548.db7ce1275db54c9fa60bd5e76713d6f4"
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
    sleep 20
  end
end 