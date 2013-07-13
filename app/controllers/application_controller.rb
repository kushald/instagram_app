class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :current_user
  before_filter :check_request
  def get_data(params)
    Request.get_request(params.merge({at: @current_user.instagram_access_token}))
  end
  private
  def current_user
    if cookies["ac"].present?
      @current_user ||= User.where(:id => cookies["ac"].split("a12b")[1]).first 
    else
      @current_user = User.find(2)
    end
  end

  def check_request
    session[:mobile] = request.user_agent =~ /Mobile|webOS/ or params[:m].to_i == 1 ? true : false
  end
end
