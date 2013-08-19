class MediaController < ApplicationController
  def likes
    @likes = Request.get_request("https://api.instagram.com/v1/media/#{params[:id]}/likes?access_token=#{@current_user.instagram_access_token}")
  end

  def comments
    @comments = Request.get_request("https://api.instagram.com/v1/media/#{params[:id]}/comments?access_token=#{@current_user.instagram_access_token}")
  end
end
