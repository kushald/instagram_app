class SiteController < ApplicationController
  require 'net/http'
  def index
    @data = Request.get_request("#{Constant::POPULAR}?client_id=#{APP_CONFIG['client_id']}")
  end

  def user
    if @current_user.blank?
      response = Request.post_request(:code => params[:code])
      @current_user = User.authenticate(
        :insta_id => response["user"]["id"],
        :access_token => response["access_token"],
        :username => response["user"]["username"],
        :full_name => response["user"]["full_name"],
        :instagram_image => response["user"]["profile_picture"]
      )

      cookies["ac"] = {:value => Array.new(10).map { (65 + rand(58)) }.join + "a12b#{@current_user.id}", :expires => Time.now+365.day}
    end
    @data = Request.get_request("#{Constant::FEED}?access_token=#{@current_user.instagram_access_token}")
    @user_info = Request.get_request("https://api.instagram.com/v1/users/#{@current_user.instagram_id}/?access_token=#{@current_user.instagram_access_token}")["data"]
  end

  def user_info
    @user_info = Request.get_request("https://api.instagram.com/v1/users/#{params[:id]}/?access_token=#{@current_user.instagram_access_token}")
    @data = Request.get_request("https://api.instagram.com/v1/users/#{params[:id]}/media/recent/?access_token=#{@current_user.instagram_access_token}")
  end
end
