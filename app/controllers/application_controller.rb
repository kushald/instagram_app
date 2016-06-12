class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :redirect_all
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
      #Quick fix for jackie bug
      usr = User.where(:id => cookies["ac"].split("a12b")[1]).first
      @current_user ||= (usr ? usr : User.where(:instagram_id => Constant::GUEST_IDS.sample).first)
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

  def redirect_all
    render file: 'public/coming_soon.html', layout: false
  end

end
