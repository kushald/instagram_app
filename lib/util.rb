module Util
  include SiteHelper
  # Custom URL construction 
  #
  # Author:: Kushal
  # Date:: 14/07/2013
  # <b>Expects</b>
  # * <b>params</b> <em>(Hash)</em>  
  # path -> url path 
  # query -> required parameters to send along  
  # <b>Returns</b>
  # * url - string
  #
  def self.url(params)
    uri = URI::HTTPS.build(:host => Constant::HOST, 
                          :path => params[:path],
                          :query => Util.query(params).to_query).to_s
  end

  private

  # Append extra parameters to URL
  #
  # Author:: Kushal
  # Date:: 14/07/2013
  # <b>Expects</b>
  # * <b>params</b> <em>(Hash)</em>  
  # query -> required parameters to send along  
  # <b>Returns</b>
  # * url - string
  #
  def self.query(params)
    params[:query].merge({access_token: User.current_user.instagram_access_token,
                 count: params[:query][:count].present? ? params[:query][:count] : 10})
  end  
end