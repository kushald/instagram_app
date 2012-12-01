class User < ActiveRecord::Base
  attr_accessible :auth_token, :instagram_access_token, :instagram_email, :instagram_full_name, :instagram_id, :instagram_image, :instagram_username, :password

  
  def self.authenticate(params)
    return {:err => 1} if params[:insta_id].blank?
    user = User.find_user(:insta_id => params[:insta_id])
    if user.present?
      user
    else
      User.create_user(params)
    end
  end

  def self.find_user(params)
    where(:instagram_id => params[:insta_id]).first
  end

  def self.create_user(params)
    create(
      :instagram_id => params[:insta_id],
      :instagram_access_token => params[:access_token],
      :instagram_username => params[:username],
      :instagram_full_name => params[:full_name]
    )
  end
end
