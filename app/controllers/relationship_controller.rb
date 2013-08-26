class RelationshipController < ApplicationController

  def follows
    parameters    = set_parameters(params)
    @user_info    = Iger::get(parameters)
    @temp_info    = temp_user_info(@user_info["data"])
    @data         = Relationship::follows(parameters)
    @relationship = Relationship::relationship(parameters) if @current_user.logged_in_user
    binding.pry
    #@user_info = Request.get_request("https://api.instagram.com/v1/users/#{instagram_id}/?access_token=#{@current_user.instagram_access_token}")
    #@temp_info = temp_user_info(@user_info["data"])
    #@data = Request.get_request("https://api.instagram.com/v1/users/#{instagram_id}/follows?access_token=#{@current_user.instagram_access_token}&cursor=#{params[:cursor]}")
    #@relationship = Request.get_request("https://api.instagram.com/v1/users/#{params[:id]}/relationship?access_token=#{@current_user.instagram_access_token}") if @current_user.logged_in_user
  end

  def followed_by
    instagram_id = params["id"] || @current_user.instagram_id
    @user_info = Request.get_request("https://api.instagram.com/v1/users/#{instagram_id}/?access_token=#{@current_user.instagram_access_token}")
    @temp_info = temp_user_info(@user_info["data"])
    if @user_info["data"].present?
      @data = Request.get_request("https://api.instagram.com/v1/users/#{instagram_id}/followed-by?access_token=#{@current_user.instagram_access_token}&cursor=#{params[:cursor]}")
      @relationship = Request.get_request("https://api.instagram.com/v1/users/#{instagram_id}/relationship?access_token=#{@current_user.instagram_access_token}") if @current_user.logged_in_user
    end
  end

end
