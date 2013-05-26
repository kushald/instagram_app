class User < ActiveRecord::Base
  attr_accessible :auth_token, :instagram_access_token, :instagram_email, :instagram_full_name, :instagram_id, :instagram_image, :instagram_username, :password

  
  def self.authenticate(params)
    return {:err => 1} if params[:insta_id].blank?
    user = User.find_user(:insta_id => params[:insta_id])
    if user.present?
      user.assign_image(params[:instagram_image]) if user.instagram_image.blank?
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
      :instagram_full_name => params[:full_name],
      :instagram_image => params[:instagram_image]
    )
  end

  def assign_image(instagram_image)
    if self.instagram_image.blank?
      self.instagram_image = instagram_image
      self.save
    end
  end
end
