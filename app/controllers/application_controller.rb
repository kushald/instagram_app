class ApplicationController < ActionController::Base
  rescue_from Exception, :with => :handle_exceptions if Rails.env == "production"
  protect_from_forgery
  before_filter :current_user
  before_filter :check_request
  def get_data(params)
    Request.get_request(params.merge({at: @current_user.instagram_access_token}))
  end

  def temp_user_info(user)
    {"user" => user}
  end
  private
  def current_user
    if cookies["ac"].present?
      @current_user ||= User.where(:id => cookies["ac"].split("a12b")[1]).first 
    else
      @current_user = User.where(:instagram_id => Constant::GUEST_IDS.sample).first
      Rails.logger.info "==================GUEST USER=============#{@current_user.instagram_id}============="
    end
    if cookies[:knc].blank? && @current_user.instagram_id == "52093116"
      cookies[:knc] = 1
    end
    User.current_user = @current_user
  end

  def check_request
    session[:mobile] = request.user_agent =~ /Mobile|webOS/ or params[:m].to_i == 1 ? true : false
  end

  def handle_exceptions(e)
    UserMailer.experror(e, request).deliver
    render :template => "public/500.html", :status => 500
  end

end
