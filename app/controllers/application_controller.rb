class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :current_user
  private
  def current_user
    redirect_to "http://www.joystagram.com"
    if cookies["ac"].present?
      @current_user ||= User.where(:id => cookies["ac"].split("a12b")[1]).first 
    else
      @current_user = User.find(2)
    end
  end
end
