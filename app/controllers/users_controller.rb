class UsersController < ApplicationController
  def likes
    instagram_id = params["id"] || @current_user.instagram_id
    @user_info = Request.get_request("https://api.instagram.com/v1/users/#{instagram_id}/?access_token=#{@current_user.instagram_access_token}")
    @data = Request.get_request("https://api.instagram.com/v1/users/self/media/liked?access_token=#{@current_user.instagram_access_token}")
  end

  def following
    instagram_id = params["id"] || @current_user.instagram_id
    @user_info = Request.get_request("https://api.instagram.com/v1/users/#{instagram_id}/?access_token=#{@current_user.instagram_access_token}")
    @data = Request.get_request("https://api.instagram.com/v1/users/#{instagram_id}/follows?access_token=#{@current_user.instagram_access_token}")
    @relationship = Request.get_request("https://api.instagram.com/v1/users/#{params[:id]}/relationship?access_token=#{@current_user.instagram_access_token}")
  end

  def followed_by
    instagram_id = params["id"] || @current_user.instagram_id
    @user_info = Request.get_request("https://api.instagram.com/v1/users/#{instagram_id}/?access_token=#{@current_user.instagram_access_token}")
    @data = Request.get_request("https://api.instagram.com/v1/users/#{instagram_id}/followed-by?access_token=#{@current_user.instagram_access_token}")
    @relationship = Request.get_request("https://api.instagram.com/v1/users/#{params[:id]}/relationship?access_token=#{@current_user.instagram_access_token}")
  end

  def my_pics
    instagram_id = params["id"] || @current_user.instagram_id
    @user_info = Request.get_request("https://api.instagram.com/v1/users/#{instagram_id}/?access_token=#{@current_user.instagram_access_token}")
    @data = Request.get_request("https://api.instagram.com/v1/users/#{instagram_id}/media/recent/?access_token=#{@current_user.instagram_access_token}")
  end

  def logout
    cookies.delete :ac
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

end
