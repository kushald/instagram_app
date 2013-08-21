class MediaController < ApplicationController
  def likes
    @likes = Request.get_request("https://api.instagram.com/v1/media/#{params[:id]}/likes?access_token=#{@current_user.instagram_access_token}")
    expires_in 5.minutes, :public => true
  end

  def comments
    @comments = Request.get_request("https://api.instagram.com/v1/media/#{params[:id]}/comments?access_token=#{@current_user.instagram_access_token}")
    expires_in 5.minutes, :public => true
  end
end
