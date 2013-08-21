class UsersController < ApplicationController

  def login_check 
    render :json => {:status => (@current_user.logged_in_user ? 1 : 0)}
  end

  def show
    id = retrieve_id(params)  
    if id.present?    
      #@user_info = Request.get_request("https://api.instagram.com/v1/users/#{id}/?access_token=#{@current_user.instagram_access_token}")
      @data = Request.get_request("https://api.instagram.com/v1/users/#{id}/media/recent/?access_token=#{@current_user.instagram_access_token}&max_id=#{params[:n]}&count=10")
      if @data["data"] == []
        @user_info = Request.get_request("https://api.instagram.com/v1/users/#{id}/?access_token=#{@current_user.instagram_access_token}")
        @temp_info = temp_user_info(@user_info["data"])
      elsif @data["data"]
        @temp_info = temp_user_info(@data["data"][0]["user"]) if @data["data"]
      end
    end
  end

  def likes
    instagram_id = params["id"] || @current_user.instagram_id
    @user_info = Request.get_request("https://api.instagram.com/v1/users/#{instagram_id}/?access_token=#{@current_user.instagram_access_token}")
    @data = Request.get_request("https://api.instagram.com/v1/users/self/media/liked?access_token=#{@current_user.instagram_access_token}&max_like_id=#{params[:n]}&count=10")
  end

  def following
    instagram_id = params["id"] || @current_user.instagram_id
    @user_info = Request.get_request("https://api.instagram.com/v1/users/#{instagram_id}/?access_token=#{@current_user.instagram_access_token}")
    @temp_info = temp_user_info(@user_info["data"])
    @data = Request.get_request("https://api.instagram.com/v1/users/#{instagram_id}/follows?access_token=#{@current_user.instagram_access_token}&cursor=#{params[:cursor]}")
    @relationship = Request.get_request("https://api.instagram.com/v1/users/#{params[:id]}/relationship?access_token=#{@current_user.instagram_access_token}") if @current_user.logged_in_user
    expires_in 3.minutes, :public => true
  end

  def followed_by
    instagram_id = params["id"] || @current_user.instagram_id
    @user_info = Request.get_request("https://api.instagram.com/v1/users/#{instagram_id}/?access_token=#{@current_user.instagram_access_token}")
    @temp_info = temp_user_info(@user_info["data"])
    if @user_info["data"].present?
      @data = Request.get_request("https://api.instagram.com/v1/users/#{instagram_id}/followed-by?access_token=#{@current_user.instagram_access_token}&cursor=#{params[:cursor]}")
      @relationship = Request.get_request("https://api.instagram.com/v1/users/#{instagram_id}/relationship?access_token=#{@current_user.instagram_access_token}") if @current_user.logged_in_user
    end
    expires_in 3.minutes, :public => true
  end

  def my_pics
    instagram_id = params["id"] || @current_user.instagram_id
    @user_info = Request.get_request("https://api.instagram.com/v1/users/#{instagram_id}/?access_token=#{@current_user.instagram_access_token}")
    @data = Request.get_request("https://api.instagram.com/v1/users/#{instagram_id}/media/recent/?access_token=#{@current_user.instagram_access_token}&max_id=#{params[:n]}")
  end

  def logout
    cookies.delete(:ac, domain: :all)
    redirect_to "/"
  end
  def relationship
    response = Request.post_request(:uri => "https://api.instagram.com/v1/users/#{params[:id]}/relationship",
                                    :type => "relationship",
                                    :action => params[:instagram_action],
                                    :access_token => @current_user.instagram_access_token)
    #TODO:: Handle error scenarios
    render :json => {}
  end

  def like_media
    response = Request.post_request(:uri => "https://api.instagram.com/v1/media/#{params["media_id"]}/likes",
                                    :access_token => @current_user.instagram_access_token)
    #TODO:: Handle error scenarios
    render :json => {}
  end

  def comment
    response = Request.post_request(:uri => "https://api.instagram.com/v1/media/#{params[:media_id]}/comments",
                                    :type => 'comment',
                                    :text => params[:text],
                                    :access_token => @current_user.instagram_access_token
                                   )
  end

  def relation
    data = Request.get_request("https://api.instagram.com/v1/users/#{params[:id]}/relationship?access_token=#{@current_user.instagram_access_token}")
    render :json => {status: data["data"]["outgoing_status"]}
  end

  def profile_count
    data = Request.get_request("https://api.instagram.com/v1/users/#{params[:id]}/?access_token=#{@current_user.instagram_access_token}")["data"]
    render :json => {media: "", followed_by: "", follows: "", bio: "", website: "", full_name: "", profile_picture: "", username: ""} and return if data.blank?
    @profile = {
                      id: data["id"],
                      media: data["counts"]["media"], 
                      followed_by: data["counts"]["followed_by"],
                      follows: data["counts"]["follows"],
                      bio: data["bio"],
                      website: data["website"],
                      full_name: data["full_name"].to_s,
                      profile_picture: data["profile_picture"],
                      username: data["username"]}
    render :layout => false
    expires_in 10.minutes, :public => true
  end

  def browse_user
    @browse_user = Request.get_request("https://api.instagram.com/v1/users/#{params[:id]}/media/recent/?access_token=#{@current_user.instagram_access_token}&count=6")["data"].shuffle
    render :layout => false
    expires_in 10.minutes, :public => true
  end

  private

  def retrieve_id(params)
    params[:fid].present? ? params[:fid] : Request.get_request("https://api.instagram.com/v1/users/search?q=#{params[:id]}&access_token=#{@current_user.instagram_access_token}")["data"][0]["id"] rescue [] 
  end
end
