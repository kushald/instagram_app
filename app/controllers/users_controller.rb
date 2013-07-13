class UsersController < ApplicationController
  
  def joystagrammers
    @users = User.all
  end
  def show
    id = Request.get_request("https://api.instagram.com/v1/users/search?q=#{params[:id]}&access_token=#{@current_user.instagram_access_token}")["data"][0]["id"] rescue []
    if id.present?    
      @user_info = Request.get_request("https://api.instagram.com/v1/users/#{id}/?access_token=#{@current_user.instagram_access_token}")
      @data = Request.get_request("https://api.instagram.com/v1/users/#{id}/media/recent/?access_token=#{@current_user.instagram_access_token}&max_id=#{params[:n]}&count=10")
      @relationship = Request.get_request("https://api.instagram.com/v1/users/#{id}/relationship?access_token=#{@current_user.instagram_access_token}")
    end
  end

  def likes
    instagram_id = params["id"] || @current_user.instagram_id
    @user_info = Request.get_request("https://api.instagram.com/v1/users/#{instagram_id}/?access_token=#{@current_user.instagram_access_token}")
    @data = Request.get_request("https://api.instagram.com/v1/users/self/media/liked?access_token=#{@current_user.instagram_access_token}&max_like_id=#{params[:n]}")
  end

  def following
    instagram_id = params["id"] || @current_user.instagram_id
    @user_info = Request.get_request("https://api.instagram.com/v1/users/#{instagram_id}/?access_token=#{@current_user.instagram_access_token}")
    @data = Request.get_request("https://api.instagram.com/v1/users/#{instagram_id}/follows?access_token=#{@current_user.instagram_access_token}&cursor=#{params[:cursor]}")
    @relationship = Request.get_request("https://api.instagram.com/v1/users/#{params[:id]}/relationship?access_token=#{@current_user.instagram_access_token}")
  end

  def followed_by
    instagram_id = params["id"] || @current_user.instagram_id
    @user_info = Request.get_request("https://api.instagram.com/v1/users/#{instagram_id}/?access_token=#{@current_user.instagram_access_token}")
    if @user_info["data"].present?
      @data = Request.get_request("https://api.instagram.com/v1/users/#{instagram_id}/followed-by?access_token=#{@current_user.instagram_access_token}&cursor=#{params[:cursor]}")
      @relationship = Request.get_request("https://api.instagram.com/v1/users/#{instagram_id}/relationship?access_token=#{@current_user.instagram_access_token}")
    end
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
    id = Request.get_request("https://api.instagram.com/v1/users/search?q=#{params[:media_id]}&access_token=#{@current_user.instagram_access_token}")["data"][0]["id"]
    response = Request.post_request(:uri => "https://api.instagram.com/v1/users/#{id}/relationship",
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
end
