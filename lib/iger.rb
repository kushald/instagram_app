module Iger

  def self.find(id)
    Request.get("users/#{id}/media/recent/")
  end
  
  def self.feed(max_id = nil)
    Request.get("users/self/feed?&max_id=#{max_id}")
  end

  def media
    Request.get("https://api.instagram.com/v1/users/#{id}/media/recent/")
  end
end