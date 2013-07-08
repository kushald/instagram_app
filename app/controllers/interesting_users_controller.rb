class InterestingUsersController < ApplicationController
  layout "charm"
  def lay

  end
  def new
    redirect_to "/" if @current_user.blank? || @current_user.un_authorized
  end

  def create_int_user_with_post 
    if params[:uname].blank? || params[:ctype].blank?
      flash[:notice] = "Invalid parameter(s)"
      render :action => "new" and return 
    end
    id = Request.get_request("https://api.instagram.com/v1/users/search?q=#{params[:uname]}&access_token=#{@current_user.instagram_access_token}")["data"][0]["id"] rescue []
    if id.blank?
      flash[:notice] = "Invalid Username"
      render :action => "new" and return
    end
    data = Request.get_request("https://api.instagram.com/v1/users/#{id}/?access_token=#{@current_user.instagram_access_token}")["data"]  
    if data.present?
      if InterestingUser.where(:instagram_user_id => data['id']).present?
        flash[:notice] = "User Entry Exists"
        render"new"
      else
        InterestingUser.create!(:instagram_user_id => data["id"],
                                 :instagram_profile_picture => data["profile_picture"],
                                 :instagram_username => data["username"],
                                 :category_type => params[:ctype])
      end
    end
  end
end
