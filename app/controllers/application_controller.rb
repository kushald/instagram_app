class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :current_user
  private
  def current_user
    @current_user ||= User.where(:id => cookies["ac"].split("a12b")[1]).first if cookies["ac"].present?
  end
end
