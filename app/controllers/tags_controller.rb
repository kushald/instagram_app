class TagsController < ApplicationController
  include TagsHelper
  def index

  end

  def show
    @data = Request.get_request("https://api.instagram.com/v1/tags/#{params[:id]}/media/recent?access_token=#{@current_user.instagram_access_token}&max_tag_id=#{params[:n]}&count=10")
  end
end
