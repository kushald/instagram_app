class SiteController < ApplicationController
  include SiteHelper
  require 'net/http'
  before_filter :store_return_to, :only => [:login]

  def index
    @interesting_user_posts = InterestingUserPost.all.sample(4).in_groups_of(2) 
    @trendings = Trending.limit(3)
    expires_in 1.hour, :public => true
  end

  def login
    redirect_to Constant::LOGIN_URL
  end

  def explore
    @interesting_user_posts = InterestingUserPost.all.sample(12)
    expires_in 15.minutes, :public => true
  end

  
  # def popular
  #   @data = Request.get_request({t: :pop, at: @current_user.instagram_access_token})
  #   @ig_users = @data["data"].collect{|d| [d["caption"]["from"]["username"],d["caption"]["from"]["profile_picture"]] if d["caption"].present?}.compact rescue []
  #   render :partial => 'content' and return if request.xhr?
  # end

  # def media
  #   #Get the details for specified media
  #   @browse_popular = InterestingUserPost.all.sample(6)
  #   @media = get_data(params.merge({t: :m}))
  #   if @media["data"].present?
  #     @user_id = @media["data"]["user"]["username"]
  #     media_id = @media["data"]["user"]["id"]
  #     @browse_user = get_data({t: :ud, mid: media_id})["data"][0..5]
  #     @relationship = get_data({t: :rel, mid: media_id})
  #   end
  # end



  def popular
    @data = Request.get_request("#{Constant::POPULAR}?access_token=#{@current_user.instagram_access_token}&count=15")
    render :partial => 'content' and return if request.xhr?
    expires_in 2.minutes, :public => true
  end

  def media
    #Get the details for specified media
    @media = Request.get_request("https://api.instagram.com/v1/media/#{params[:id]}?access_token=#{@current_user.instagram_access_token}")
    if @media["data"].present?
      @user_id = @media["data"]["user"]["username"]
    end
  end

  def user
    if @current_user.blank? || @current_user.guest_user
      redirect_to "/" and return if params[:code].blank?
      response = Request.post_request(:uri => "https://api.instagram.com/oauth/access_token", :code => params[:code], :type => "access_token")
      @current_user = User.authenticate(
        :insta_id => response["user"]["id"],
        :access_token => response["access_token"],
        :username => response["user"]["username"],
        :full_name => response["user"]["full_name"],
        :instagram_image => response["user"]["profile_picture"]
      )
      cookies["ac"] = {:value => Array.new(10).map { (65 + rand(58)) }.join + "a12b#{@current_user.id}", :expires => Time.now+365.day, :domain => :all}
    end
    if session[:return_to].present? && session[:return_to].index("media")
      redirect = session[:return_to]
      session[:return_to] = NIL 
      redirect_to redirect
    end
    @data = Request.get_request("https://api.instagram.com/v1/users/self/feed?access_token=#{@current_user.instagram_access_token}&max_id=#{params[:n]}")
    @temp_info = {"user" => {"username" => @current_user.instagram_username, "profile_picture" => @current_user.instagram_image, "id" => @current_user.instagram_id}} if @current_user.logged_in_user
    @user_info = Request.get_request("https://api.instagram.com/v1/users/#{@current_user.instagram_id}/?access_token=#{@current_user.instagram_access_token}")
  end

  def user_info
    @user_info = Request.get_request("https://api.instagram.com/v1/users/#{params[:id]}/?access_token=#{@current_user.instagram_access_token}")
    if @user_info["data"]
      @data = Request.get_request("https://api.instagram.com/v1/users/#{params[:id]}/media/recent/?access_token=#{@current_user.instagram_access_token}&max_id=#{params[:n]}")
      @temp_info = temp_user_info(@user_info["data"])
      @relationship = Request.get_request("https://api.instagram.com/v1/users/#{params[:id]}/relationship?access_token=#{@current_user.instagram_access_token}") if @current_user.logged_in_user
    end
  end

  def geo_tag_content
    location = Geokit::Geocoders::MultiGeocoder.geocode(request.remote_ip).city || 'Belgaum'
    @data = Request.get_request("https://api.instagram.com/v1/tags/#{location}/media/recent?access_token=#{@current_user.instagram_access_token}&max_tag_id=#{params[:n]}&count=11")
    render '/users/likes' and return
  end

  def search
    if params[:q].present?
      q = params[:q].gsub(/\s+/, "")
      if params[:kind] == "user"
        @data = Request.get_request("https://api.instagram.com/v1/users/search?q=#{q}&access_token=#{@current_user.instagram_access_token}")
      else
        @data = Request.get_request("https://api.instagram.com/v1/tags/#{q}/media/recent?access_token=#{@current_user.instagram_access_token}&max_tag_id=#{params[:n]}")
      end
    end
    expires_in 5.minutes, :public => true
  end

  def pagination
    @data = Request.get_request("https://api.instagram.com/v1/users/self/feed?access_token=#{@current_user.instagram_access_token}")
    render :json => {:html => render_to_string(partial: 'content'), :next_max_id => @data["pagination"]["next_max_id"]}
  end

  def about
    expires_in 10.hour, :public => true
  end

  def terms
    expires_in 10.hour, :public => true
  end

  def privacy
    expires_in 10.hour, :public => true
  end

  def faq
    expires_in 10.hour, :public => true
  end

  def apparel
    id = if params[:b].present?
          Request.get_request("https://api.instagram.com/v1/users/search?q=#{params[:b]}&access_token=#{@current_user.instagram_access_token}")["data"][0]["id"] rescue nil
        else
          "230938948"
        end
    @data = Request.get_request("https://api.instagram.com/v1/users/#{id}/media/recent/?access_token=#{@current_user.instagram_access_token}&max_id=#{params[:n]}")
    expires_in 5.hour, :public => true
  end

  def store_return_to
    session[:return_to] = request.referrer
  end
end
