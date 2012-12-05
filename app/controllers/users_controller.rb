class UsersController < ApplicationController
  def likes
    @data = Request.get_request("https://api.instagram.com/v1/users/self/media/liked?access_token=#{@current_user.instagram_access_token}")
  end

  def following
    @data = Request.get_request("https://api.instagram.com/v1/users/#{@current_user.instagram_id}/follows?access_token=#{@current_user.instagram_access_token}")["data"]
  end

  def followed_by
    @data = Request.get_request("https://api.instagram.com/v1/users/#{@current_user.instagram_id}/followed-by?access_token=#{@current_user.instagram_access_token}")["data"]
  end

  def my_pics
    @data = Request.get_request("https://api.instagram.com/v1/users/#{@current_user.instagram_id}/media/recent/?access_token=#{@current_user.instagram_access_token}")["data"]
  end
end
