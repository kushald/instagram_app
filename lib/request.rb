module Request
  def self.get_request(uri)
    JSON.parse((HTTParty.get(uri)).body)
  end

  def self.post_request(params)
    JSON.parse((HTTParty.post(params[:uri], :body => self.post_request_body(params))).body)
  end

  private
  def self.post_request_body(params)
    if params[:type] == 'access_token'
      {
        'client_id' => APP_CONFIG['client_id'],
        'client_secret' => APP_CONFIG['client_secret'],
        'grant_type' => 'authorization_code',
        'redirect_uri' => APP_CONFIG['redirect_uri'],
        'code' => params[:code]
      }
    else
      {
        'access_token' => params[:access_token],
        'action' => params[:action]
      }
    end
  end
end