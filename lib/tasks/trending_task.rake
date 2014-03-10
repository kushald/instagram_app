task :create_trending => :environment do
  ac = User.find(1).instagram_access_token
  #Trending.delete_all
  users = Request.get_request("#{Constant::POPULAR}?access_token=#{ac}")["data"]

  users.each_with_index do |user,i|
    profile = Request.get_request("https://api.instagram.com/v1/users/#{user["user"]["id"]}/?access_token=#{ac}")["data"]
    begin
      Trending.create!(:instagram_id => profile["id"],
                      :username => profile["username"],
                      :full_name => profile["full_name"],
                      :bio => profile["bio"],
                      :website =>profile["website"],
                      :profile_image => profile["profile_picture"],
                      :uploads => profile["counts"]["media"],
                      :followed_by => profile["counts"]["followed_by"],
                      :follows => profile["counts"]["follows"],
                      :media_id => user["id"],
                      :media => user["images"]["low_resolution"]["url"],
                      :media_type => user["type"])
      p "=============================#{i}.#{profile["id"]}================"
    rescue ActiveRecord::RecordNotUnique
      p "=============================#{profile["id"]}================"
    end
  end
end