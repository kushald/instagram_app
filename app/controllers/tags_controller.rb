class TagsController < ApplicationController
  include TagsHelper
  def index
    expires_in 1.hour, :public => true
  end

  def show
    @data = Request.get_request("https://api.instagram.com/v1/tags/#{params[:id]}/media/recent?access_token=#{@current_user.instagram_access_token}&max_tag_id=#{params[:n]}")
    expires_in 5.minutes, :public => true
  end
end
