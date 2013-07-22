class SiteController < ApplicationController
  include SiteHelper
  require 'net/http'

  before_filter :store_return_to, :only => [:login]

  def login
    redirect_to Constant::LOGIN_URL
  end

  def index
    @interesting_users = InterestingUser.where(:category_type => [1,2].sample).all.sample(8).index_by(&:instagram_user_id)
    #redirect_to "/popular" if @interesting_users.blank?
    @interesting_user_posts = InterestingUserPost.where(:instagram_user_id => @interesting_users.keys).all.shuffle.group_by(&:instagram_user_id)
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
    @data = Request.get_request("#{Constant::POPULAR}?access_token=#{@current_user.instagram_access_token}")
    @ig_users = @data["data"].collect{|d| [d["caption"]["from"]["username"],d["caption"]["from"]["profile_picture"]] if d["caption"].present?}.compact rescue []
    render :partial => 'content' and return if request.xhr?
  end

  def media
    #Get the details for specified media
    @media = Request.get_request("https://api.instagram.com/v1/media/#{params[:id]}?access_token=#{@current_user.instagram_access_token}")
    if @media["data"].present?
      @user_id = @media["data"]["user"]["username"]
      if !session[:mobile]
        @browse_user = Request.get_request("https://api.instagram.com/v1/users/#{@media["data"]["user"]["id"]}/media/recent/?access_token=#{@current_user.instagram_access_token}&count=6")["data"].shuffle
        celeb = InterestingUser.where(:category_type => 2).collect(&:instagram_user_id)      
        @browse_popular = InterestingUserPost.where(:instagram_user_id => celeb).sample(6)
      end
      @relationship = Request.get_request("https://api.instagram.com/v1/users/#{@media["data"]["user"]["id"]}/relationship?access_token=#{@current_user.instagram_access_token}") if @current_user.logged_in_user
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
    @data = Request.get_request("https://api.instagram.com/v1/users/self/feed?access_token=#{@current_user.instagram_access_token}&max_id=#{params[:n]}&count=10")
    @temp_info = {"user" => {"username" => @current_user.instagram_username, "profile_picture" => @current_user.instagram_image, "id" => @current_user.instagram_id}} if @current_user.logged_in_user
    @user_info = Request.get_request("https://api.instagram.com/v1/users/#{@current_user.instagram_id}/?access_token=#{@current_user.instagram_access_token}")
  end

  def user_info
    @user_info = Request.get_request("https://api.instagram.com/v1/users/#{params[:id]}/?access_token=#{@current_user.instagram_access_token}")
    @data = Request.get_request("https://api.instagram.com/v1/users/#{params[:id]}/media/recent/?access_token=#{@current_user.instagram_access_token}&max_id=#{params[:n]}")
    @relationship = Request.get_request("https://api.instagram.com/v1/users/#{params[:id]}/relationship?access_token=#{@current_user.instagram_access_token}") if @current_user.logged_in_user
  end

  def geo_tag_content
    location = Geokit::Geocoders::MultiGeocoder.geocode(request.remote_ip).city || 'Belgaum'
    @data = Request.get_request("https://api.instagram.com/v1/tags/#{location}/media/recent?access_token=#{@current_user.instagram_access_token}&max_tag_id=#{params[:n]}")
    render '/users/likes' and return
  end

  def search
    if params[:q].present?
      @data_tags = Request.get_request("https://api.instagram.com/v1/tags/#{params[:q]}/media/recent?access_token=#{@current_user.instagram_access_token}&max_tag_id=#{params[:n]}")
      @data_users = Request.get_request("https://api.instagram.com/v1/users/search?q=#{params[:q]}&access_token=#{@current_user.instagram_access_token}")
    end
  end

  def pagination
    @data = Request.get_request("https://api.instagram.com/v1/users/self/feed?access_token=#{@current_user.instagram_access_token}")
    render :json => {:html => render_to_string(partial: 'content'), :next_max_id => @data["pagination"]["next_max_id"]}
  end

  def about
  end

  def store_return_to
    session[:return_to] = request.referrer
  end
end
