class SiteController < ApplicationController
  include SiteHelper
  require 'net/http'

  before_filter :store_return_to, :only => [:login]

  def login
    redirect_to Constant::LOGIN_URL
  end

  def index
    @interesting_users = InterestingUser.all.index_by(&:instagram_user_id)
    @interesting_user_posts = InterestingUserPost.all.shuffle.group_by(&:instagram_user_id)
  end

  def popular
    @data = Request.get_request("#{Constant::POPULAR}?access_token=#{@current_user.instagram_access_token}")
    @ig_users = @data["data"].collect{|d| [d["caption"]["from"]["username"],d["caption"]["from"]["profile_picture"]] if d["caption"].present?}.compact rescue []
    render :partial => 'content' and return if request.xhr?
  end

  def media
    #Get the details for specified media
    @media = Request.get_request("https://api.instagram.com/v1/media/#{params[:id]}?access_token=#{@current_user.instagram_access_token}")
    @user_id = @media["data"]["user"]["username"]
    @browse_user = Request.get_request("https://api.instagram.com/v1/users/#{@media["data"]["user"]["id"]}/media/recent/?access_token=#{@current_user.instagram_access_token}")["data"][0..5]
    @browse_popular = Request.get_request("#{Constant::POPULAR}?client_id=#{APP_CONFIG['client_id']}")["data"][0..5]
    @relationship = Request.get_request("https://api.instagram.com/v1/users/#{@media["data"]["user"]["id"]}/relationship?access_token=#{@current_user.instagram_access_token}")
  end

  def user
    if @current_user.blank? || @current_user.guest_user
      response = Request.post_request(:uri => "https://api.instagram.com/oauth/access_token", :code => params[:code], :type => "access_token")
      @current_user = User.authenticate(
        :insta_id => response["user"]["id"],
        :access_token => response["access_token"],
        :username => response["user"]["username"],
        :full_name => response["user"]["full_name"],
        :instagram_image => response["user"]["profile_picture"]
      )
      cookies["ac"] = {:value => Array.new(10).map { (65 + rand(58)) }.join + "a12b#{@current_user.id}", :expires => Time.now+365.day}
    end
    if session[:return_to].present? 
      redirect = session[:return_to]
      session[:return_to] = NIL 
      redirect_to redirect
    end
    @data = Request.get_request("#{Constant::FEED}?access_token=#{@current_user.instagram_access_token}")
    @user_info = Request.get_request("https://api.instagram.com/v1/users/#{@current_user.instagram_id}/?access_token=#{@current_user.instagram_access_token}")
  end

  def user_info
    @user_info = Request.get_request("https://api.instagram.com/v1/users/#{params[:id]}/?access_token=#{@current_user.instagram_access_token}")
    @data = Request.get_request("https://api.instagram.com/v1/users/#{params[:id]}/media/recent/?access_token=#{@current_user.instagram_access_token}")
    @relationship = Request.get_request("https://api.instagram.com/v1/users/#{params[:id]}/relationship?access_token=#{@current_user.instagram_access_token}")
  end

  def geo_tag_content
    location = Geokit::Geocoders::MultiGeocoder.geocode(request.remote_ip).city || 'Belgaum'
    @data = Request.get_request("https://api.instagram.com/v1/tags/#{location}/media/recent?access_token=#{@current_user.instagram_access_token}")
    render '/users/likes' and return
  end

  def search
    query = params[:q].present? ?  params[:q] : "search"
    @data = Request.get_request("https://api.instagram.com/v1/tags/#{query}/media/recent?access_token=#{@current_user.instagram_access_token}")
  end

  def pagination
    @data = Request.get_request("https://api.instagram.com/v1/users/self/feed?access_token=#{@current_user.instagram_access_token}&max_id=#{params[:next_max_id]}")
    render :json => {:html => render_to_string(partial: 'content'), :next_max_id => @data["pagination"]["next_max_id"]}
  end

  def about
  end

  def store_return_to
    session[:return_to] = request.referrer
  end
end
